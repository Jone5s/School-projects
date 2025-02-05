using System;
using System.Globalization;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EUMembers
{

public class Program
{
    public static void Main()
    {
        var currentCulture = CultureInfo.CurrentCulture;
        Console.WriteLine($"Current culture = {currentCulture}");

            foreach (var country in CountryManager.Instance.Countries)
            {
                Console.WriteLine(country.Name);
                Console.WriteLine($"Population: {country.Population:N0}");
                Console.WriteLine($"Area: {country.Area:N0} km\xB2");
                Console.WriteLine($"Population density: {country.PopulationDensity:N0} people per km\xB2");

                Console.WriteLine($"Joined the EU on {country.Joined}");
                if (country.Euro != null)
                {
                    Console.WriteLine($"Joined the euro on {country.Euro!}");
                }
                if (country.Schengen != null)
                {
                    Console.WriteLine($"Joined the Schengen agreement on {country.Schengen}");
                }
                if (country.Exited != null)
                {
                    Console.WriteLine($"Exited the EU on {country.Exited!}");
                }
                Console.WriteLine();
            
              
            }
            Console.WriteLine("Nations that have been in the EU for more than 25 years:");
            var euMemberPlus25 = CountryManager.Instance.Countries
             .Where(c => c.Joined.Year <= DateTime.Today.Year - 25 && c.Exited == null)
            .OrderByDescending(c => c.Joined);

            foreach (var country in euMemberPlus25)
            {
                Console.WriteLine(country.Name);
            }

            Console.WriteLine();
            Console.WriteLine("Nations that are part of eurozone:");

            var euEurozone = CountryManager.Instance.Countries
             .Where(c => c.Euro != null)
             .OrderByDescending(c => c.Joined);

            foreach (var country in euEurozone)
            {
                Console.WriteLine(country.Name);
            }

            Console.WriteLine();
            Console.WriteLine("Nations that joined the EU on a day other than Jan 1:");

            var euNonJan1Members = CountryManager.Instance.Countries
             .Where(c => c.Joined.Month != 1 && c.Joined.Year != 0);

            foreach (var country in euNonJan1Members)
            {
                Console.WriteLine(country.Name);
            }

            Console.WriteLine();

            var schengenCount = CountryManager.Instance.Countries
            .Count(c => c.Schengen != null);

            Console.WriteLine("Number of Schengen countries in EU: " + schengenCount);
        }
    }
}