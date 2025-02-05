#include <iostream> // for standard I/O streams
#include <iomanip>  // for stream control
#include <string>   // for std::string class
#include <cstdlib>  // for std::getenv
#include <chrono>   // for the std::chrono facilities
#include <sstream>  // for std::stringstream class
#include <vector>   // for std::vector class
#include <optional> // for std::optional
#include <string_view>  // for std::string_view
#include <filesystem>  // for path utilities
#include <memory>   // for smart pointers
#include <fstream>  // for file manipulation

#include "event.h"  // for our Event class
#include "rapidcsv.h"  // for the header-only library RapidCSV
#include "commandHandling.h" // for handling the commands given by the user

void addEvent(std::vector<Event>& events,std::string d,std::string category, std::string description) { 

    // adds an event to the vector wiht the given information
    
    const auto date = getDateFromString(d);
    if (!date.has_value()) {
        std::cout << "Invalid date format. Event not added." << std::endl;
        return;
    }
    Event event(date.value(), category, description);
    events.push_back(event);
    std::cout << "Event added successfully." << std::endl;
}

void saveEventsToCSV(const std::string& filePath, const std::vector<Event>& events) {
    
    // at the end of the program this function saves the changes made to the events vector
    // to the csv file

    rapidcsv::Document document;
    document.SetColumnName(0, "date");
    document.SetColumnName(1, "category");
    document.SetColumnName(2, "description");

    for (const auto& event : events) {
        std::vector<std::string> row;
        row.push_back(getStringFromDate(event.getTimestamp()));
        row.push_back(event.getCategory());
        row.push_back(event.getDescription());

        document.InsertRow(document.GetRowCount(), row);
    }

    document.Save(filePath);
    //std::cout << "Events saved to " << filePath << std::endl;
}

int main(int argc, char *argv[]) {
    using namespace std;
    using namespace std::chrono_literals;

    // Get the current date from the system clock and extract year_month_day.
    // See https://en.cppreference.com/w/cpp/chrono/year_month_day
    const chrono::time_point now = chrono::system_clock::now();
    const chrono::year_month_day currentDate{chrono::floor<chrono::days>(now)};

    // Check the birthdate and user with generic helper functions
    auto birthdateValue = getEnvironmentVariable("BIRTHDATE");
    if (birthdateValue.has_value()) {
        auto birthdate = getDateFromString(birthdateValue.value());
        ostringstream message;
        if (birthdate.has_value()) {
            auto b = birthdate.value();
            if (b.month() == currentDate.month() && b.day() == currentDate.day()) {
                message << "Happy birthday";
                auto userEnv = getEnvironmentVariable("USER");
                if (userEnv.has_value()) {
                    auto user = userEnv.value();
                    message << ", " << user;
                }
                message << "! ";
            }

            int age = getNumberOfDaysBetween(
                chrono::floor<chrono::days>(chrono::sys_days{b}),
                chrono::floor<chrono::days>(chrono::sys_days{currentDate})
            );

            message << "You are " << age << " days old.";
            if (age % 1000 == 0) {
                message << " That's a nice round number!";
            }

            display(message.str()); newline();
        }
    }

    // Note that you can't print an `std::chrono::year_month_day`
    // with `display()` because there is no overloaded << operator
    // for it (yet).

    // Construct a path for the events file.
    // If the user's home directory can't be determined, give up.
    string homeDirectoryString;
    auto homeString = getEnvironmentVariable("HOME");
    if (!homeString.has_value()) {
        // HOME not found, maybe this is Windows? Try USERPROFILE.
        auto userProfileString = getEnvironmentVariable("USERPROFILE");
        if (!userProfileString.has_value()) {
            std::cerr << "Unable to determine home directory";
            return 1;
        }
        else {
            homeDirectoryString = userProfileString.value();
        }
    }
    else {
        homeDirectoryString = homeString.value();
    }

    namespace fs = std::filesystem; // save a little typing
    fs::path daysPath{homeDirectoryString};
    daysPath /= ".days"; // append our own directory
    if (!fs::exists(daysPath)) {
        display(daysPath.string());
        display(" does not exist, please create it");
        newline();
        return 1;  // nothing to do anymore, exit program

        // To create the directory:
        //std::filesystem::create_directory(daysPath);
        // See issue: https://github.com/jerekapyaho/days_cpp/issues/4
    }

    // Now we should have a valid path to the `~/.days` directory.
    // Construct a pathname for the `events.csv` file.
    auto eventsPath = daysPath / "events.csv";

    //
    // Read in the CSV file from `eventsPath` using RapidCSV
    // See https://github.com/d99kris/rapidcsv
    //
    rapidcsv::Document document{eventsPath.string()};
    vector<string> dateStrings{document.GetColumn<string>("date")};
    vector<string> categoryStrings{document.GetColumn<string>("category")};
    vector<string> descriptionStrings{document.GetColumn<string>("description")};

    vector<Event> events;
    for (size_t i{0}; i < dateStrings.size(); i++) {
        auto date = getDateFromString(dateStrings.at(i));
        if (!date.has_value()) {
            cerr << "bad date at row " << i << ": " << dateStrings.at(i) << '\n';
            continue;
        }

        Event event{
            date.value(),
            categoryStrings.at(i),
            descriptionStrings.at(i)
        };
        events.push_back(event);
    }

    const auto today = chrono::sys_days{
        floor<chrono::days>(chrono::system_clock::now())};

    if (argc > 1) {
        std::string command = argv[1];

        if (command == "list") {
            if (argc > 2) {
                std::string option = argv[2];
                
                if (option == "--today") {
                    // show all events today
                    showEventsOnDate(events, today, today);
                } if (option == "--before-date") {
                    // show all events on given date or before it
                    if (argc > 3) {
                        std::string d = argv[3];
                        const auto targetDate = getDateFromString(d);
                        if(argc > 4){
                            std::string d2 = argv[5];
                            const auto targetDate2 = getDateFromString(d2);
                            showBetweenDates(events, today, targetDate, targetDate2);
                        } else
                            showBeforeDate(events, today, targetDate);
                        
                    }
                }   else if (option == "--after-date") {
                    // show all events on given date or after it
                    if (argc > 3) {
                        std::string d = argv[3];
                        const auto targetDate = getDateFromString(d);
                        showAfterDate(events,today, targetDate);
                    }
                }   else if (option == "--date") {
                    // show all events on given date
                    if (argc > 3) {
                        std::string d = argv[3];
                        const auto targetDate = getDateFromString(d);
                        showEventsOnDate(events,today ,targetDate);
                    }
                }   else if (option == "--categories") {
                    // show all events that are included in the given category
                    if (argc > 3) {
                        std::vector<std::string> categories;
                        for (int i = 3; i < argc; ++i) {
                            categories.push_back(argv[i]);
                        }
                        showEventsByCategory(events, categories,true,today);
                    }
                } else if (option == "--exclude") {
                    // show all events that arent included in the given category
                    if (argc > 3) {
                        std::vector<std::string> categories;
                        for (int i = 3; i < argc; ++i) {
                            categories.push_back(argv[i]);
                        }
                        showEventsByCategory(events, categories, false, today);
                    }
                }   else if (option == "--no-category") {
                    // show all the events with no category
                    showWithNoCategory(events, today);
                }
            }
               
            
        else {
            showAllEvents(events, today);

        }
        }
        else if (command == "add") {

            std::string option = argv[2];
            std::string date = "";
            std::string category = "";
            std::string description = "";

            if (option == "--date" && argc > 4) {
                // check if the date is given by the user or if the date is to be assigned as today
                date = argv[3];
                if (argc > 5) {
                    category = argv[5];
                    if (argc > 6) {
                        description = argv[7];
                    }
                }
        }   else {
                date = getStringFromDate(today);
        }  
        if (option == "--category") {
                // check if the category is given
                category = argv[3];
                description = argv[5];    
                }
            
        else {
            description = argv[7];
        }
        addEvent(events, date, category, description);

        } else if (command == "delete") {

                std::string option = argv[2];

                bool dryrun = false;
                for (int i = 1; i < argc; i++) {
                std:string drString = argv[i];
                if (drString == "--dry-run") {
                    // check if the user wants to run the command as dry run
                    dryrun = true;
                    break;
                    }
                }
                if (option == "--description" && argc > 3) {
                    std::string description = argv[3];
                    deleteEventsByDescription(events, description, dryrun);
                }
                if (option == "--category" && argc > 3) {
                    std::string category = argv[3];
                    deleteEventsByCategory(events, category, dryrun);
                } 
                else if (option == "--date" && argc > 3) {
                    std::string date = argv[3];
                    deleteEventsByDate(events, date, dryrun);
                } 
                else if (option == "--date" && argc > 4 && std::string(argv[4]) == "--category" && argc > 5) {
                    std::string date = argv[3];
                    std::string category = argv[5];
                    deleteEventsByDateAndCategory(events, date, category, dryrun);
                } 
                else if (option == "--date" && argc > 4 && std::string(argv[4]) == "--category" && argc > 7 && std::string(argv[6]) == "--description" && argc > 8) {
                    std::string date = argv[3];
                    std::string category = argv[5];
                    std::string description = argv[8];
                    deleteEventsByDateCategoryAndDescription(events, date, category, description, dryrun);
                } 
                else if (option == "--all") {
                    deleteAllEvents(events, dryrun);
                } 
            
        }
    
    }

    saveEventsToCSV(eventsPath.string(),events); // save the modifications to the csv

    return 0;
}
      

