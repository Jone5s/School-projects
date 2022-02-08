#include <iostream>
#include <iomanip>
#include <random>
#include <string>

using namespace std;

int main();

int varausnumeroarvonta(); // Aliojelma arpoo satunnaisen varausnumeron
double alennusarvonta(); // Aliohjelma alennuksen suuruuden arpomiseen
int huonemaara(); // Aliohjelma arpoo huoneiden parillisen m‰‰r‰n
int huonenro(int a, int b); // Aliohjelma arpoo huoneen numeron
bool varaus(bool a); // Aliohjelma tarkistaa ettei huone ole varattu


struct Huone
{
    float hinta = 100, varaushinta;
    int yomaara, huonenumero;
    bool varaus = false, kahden_hengen = false;
    string varaajan_nimi, varausnumero;
}; // structi huoneille


int main()
{
    setlocale(LC_ALL, "fi-FI");

    int valinta, valinta2, valinta3, huonekoko_valinta, a, koko, huonevalinta, varatut1h = 0, varatut2h = 0; // "valinta" muuttujat liittyv‰t eri valikkojen eri vaihtoehtoihin. "a", on v‰liakainen int joka muutetaan varausnumeroksi. "koko" on hotellin koko. 
    double alennus;
    bool lopetus = false, virhe, eivarausta, onko_varauksia = false, varaustila = false; /* "lopetus" m‰‰ritt‰‰ ohjelman lopetuksen. "virhe" liittyy virheentarkistukseen. "eivarausta" liittyy varauksen etsint‰‰n.
                                                                                            "onko_varauksia" liittyy ominaisuuteen, joka ei anna k‰ytt‰j‰n etsi‰ varauksia jos niit‰ ei ole viel‰ tehty.*/
    string syote; // "syote" on k‰ytt‰j‰n syˆte etsiess‰ huonetta

    koko = huonemaara();
    Huone huoneet[300];
    /*K‰yt‰n 300 kokoista taulukkoa vaikka huoneita voi olla v‰hemm‰nkin,
      loput ovat vain k‰ytt‰m‰ttˆmi‰ ja niit‰ ei voi varata eik‰ lˆyt‰‰*/

    for (int i = 1; i < koko; i++) {

        if (i >= koko / 2) {
            huoneet[i].kahden_hengen = true;
            huoneet[i].hinta = 150;
        }
    }// Muutetaan loppupuoli huoneista kahdelle hengelle


    while (lopetus == false) {





        cout << "Mit‰ haluaisit tehd‰? (Syˆta numero 1-4)\n";
        do
        {
            virhe = false;
            cout << "1: Varaa huone \n2: Katso huoneiden tiedot\n3: Lˆyd‰ huoneesi\n4: Lopeta \n";
            cin >> valinta;

            if (cin.fail() || valinta <= 0 || valinta > 4) // Ohjelman p‰‰valikko virheentarkistuksella
            {
                cout << "Virhe. V‰‰r‰ syˆttˆ!" << endl;
                virhe = true;
                cin.clear();
                cin.ignore(80, '\n');
            }
        } while (virhe);

        switch (valinta) { // Valikon switch case
        case 1: // Huoneen varaus:

            do
            {
                virhe = false;
                cout << "Valitse huonetyyppi \n1: yhden hengen huone (100 euroa yˆlt‰) Vapaana " << koko / 2 - varatut1h << "\n2: kahden hengen huone (150 euroa yˆlt‰) Vapaana " << koko / 2 - varatut2h << "\n" << "3: Takaisin\n";
                cin >> huonekoko_valinta;
                if (cin.fail() || huonekoko_valinta < 1 || huonekoko_valinta > 3)
                {
                    cout << "Virhe. V‰‰r‰ syˆttˆ.\n" << endl;
                    virhe = true;
                    cin.clear();
                    cin.ignore(80, '\n');
                }   // Valikko huonetyypin valinnalle


            } while (virhe);

            if (huonekoko_valinta == 3) {
                cout << endl;
                break;
            }

            if (huonekoko_valinta == 1)
                if (varatut1h >= koko / 2) {
                    cout << "Ei vapaita yhden hengen huoneita.\n\n";
                    cout << "Paina ENTER jatkaaksesi.\n";
                    cin.clear();
                    cin.ignore();
                    getchar();
                    break;
                }
            if (huonekoko_valinta == 2)
                if (varatut2h >= koko / 2) {
                    cout << "Ei vapaita kahden hengen huoneita.\n\n";
                    cout << "Paina ENTER jatkaaksesi.\n";
                    cin.clear();
                    cin.ignore();
                    getchar();
                    break;
                }


        tarkistus:

            huonevalinta = huonenro(huonekoko_valinta, koko); // Varataan satunnainen huone riippuen huonekoosta

            if (huonevalinta > koko / 2)
                varatut2h++;
            else
                varatut1h++;

            varaustila = varaus(huoneet[huonevalinta].varaus);

            if (varaustila == true)
                goto tarkistus;

            huoneet[huonevalinta].varaus = true;

            huoneet[huonevalinta].huonenumero = huonevalinta;


            do
            {
                virhe = false;
                cout << "Syˆt‰ ˆiden m‰‰r‰ (max 30)\n";
                cin >> huoneet[huonevalinta].yomaara;
                if (cin.fail() || huoneet[huonevalinta].yomaara <= 0 || huoneet[huonevalinta].yomaara > 30)
                {
                    cout << "Virhe. V‰‰r‰ syˆttˆ.\n" << endl;
                    virhe = true;
                    cin.clear();
                    cin.ignore(80, '\n');
                }


            } while (virhe);
            cout << "Syˆt‰ varaajan nimi: \n";
            cin.clear();
            cin.ignore();
            getline(cin, huoneet[huonevalinta].varaajan_nimi); // Tallennetaan varaajan nimi valittuun huoneeseen

            a = varausnumeroarvonta();

            huoneet[huonevalinta].varausnumero = to_string(a); // Muutan varausnumeron string-muotoon, koska stringin kanssa tyˆskentely on mielest‰ni muuttumattomissa ja pitkiss‰ luvuissa helpompaa

            onko_varauksia = true;



            alennus = alennusarvonta(); // Arvotaan alennuksen m‰‰r‰ aliohjelmalla
            huoneet[huonevalinta].varaushinta = (huoneet[huonevalinta].yomaara * huoneet[huonevalinta].hinta) * alennus; // Lasketaan huoneen hinta mahdollisen alennuksen kanssa

            cout << "Huone nro. " << huonevalinta << " varattu, " << huoneet[huonevalinta].yomaara << " yˆksi, nimell‰: " << huoneet[huonevalinta].varaajan_nimi << ", varausnumerolla: " << huoneet[huonevalinta].varausnumero << endl << "Varauksen hinta: " << huoneet[huonevalinta].varaushinta << " euroa (alennus " << 100 - alennus * 100 << " %)\n\n";
            cout << "Paina ENTER jatkaaksesi.\n";
            getchar(); // Ohjelma vaatii k‰ytt‰j‰lt‰ jonkin inputin, vaikkapa vain enterin painalluksen jatkuakseen. Mielest‰ni helpottaa ohjelman ymm‰rt‰mist‰
            cout << "\n\n";

            lopetus = false;
            break;

        case 2: // Lista huoneista, melko turha toiminto, mutta helpotti itse‰ni tarkistamaan ohjelman toimintaa

            for (int i = 1; i < koko; i++) {
                if (huoneet[i].varaus == true)
                    cout << "Huone nro. " << i << " Varattu " << endl;
                else if (huoneet[i].varaus == false)
                    cout << "Huone nro. " << i << " Vapaa" << endl;
            }
            cout << "\nPaina ENTER jatkaaksesi.\n";
            cin.clear();
            cin.ignore();
            getchar();
            lopetus = false;
            break;

        case 3: // Huoneen tietojen etsint‰ sek‰ k‰ytt‰j‰n halutessa varauksen peruminen

            if (onko_varauksia == true) {

                do
                {
                    virhe = false;
                    cout << "Etsi huone: \n1: Varausnumerolla\n2: Varaajan nimell‰\n\n";
                    cin >> valinta3;
                    if (cin.fail() || valinta3 > 2 || valinta3 < 1)
                    {
                        cout << "Virhe. V‰‰r‰ syˆttˆ.\n" << endl;
                        virhe = true;
                        cin.clear();
                        cin.ignore(80, '\n');
                    }


                } while (virhe);

                if (valinta3 == 1) {
                    cout << "Syˆt‰ varausnumero:\n\n";
                    cin.clear();
                    cin.ignore();
                    cin >> syote;
                }

                if (valinta3 == 2) {
                    cout << "Syˆt‰ varaajan nimi:\n\n";
                    cin.clear();
                    cin.ignore();
                    getline(cin, syote);
                }




                for (int i = 1; i < 300; i++) {

                    if (syote == huoneet[i].varausnumero && huoneet[i].varaus == true || syote == huoneet[i].varaajan_nimi) { /* Etsit‰‰n varasunumeroa tai nime‰ vastaava huonevaraus,
                        jos samalla nimell‰ on varattu useampi huone, voidaan kaikkien tiedot katsoa ja perua vain haluttujen huoneiden varaukset*/
                        cout << "Varattu huone: " << i << ", " << huoneet[i].yomaara << " yˆksi\nNimell‰: " << huoneet[i].varaajan_nimi << "\nVarausnumero: " << huoneet[i].varausnumero << " \nVarauksen hinta: " << huoneet[i].varaushinta << " euroa\n";
                        do
                        {
                            virhe = false;
                            cout << "\n1: Peru varaus \n2: Jatka \n";
                            cin >> valinta2;
                            if (cin.fail())
                            {
                                cout << "Virhe. V‰‰r‰ syˆttˆ.\n" << endl;
                                virhe = true;
                                cin.clear();
                                cin.ignore(80, '\n');
                            }


                        } while (virhe);
                        if (valinta2 == 1) {
                            huoneet[i].varaus = false;
                            huoneet[i].varausnumero.clear();
                            huoneet[i].varaajan_nimi.clear();
                            huoneet[i].varaushinta = 0;
                            huoneet[i].yomaara = 0;

                            if (huoneet[i].huonenumero > koko / 2)
                                varatut2h--;
                            else
                                varatut1h--;

                            cout << "Varaus peruttu.\n\n";  // Perutaan varaus, sek‰ tyhjennet‰‰n huoneesta tarvittavat tiedot
                            valinta2 = 0;
                            cout << "Paina ENTER jatkaaksesi.\n";
                            cin.clear();
                            cin.ignore();
                            getchar();
                        }
                    }
                    else
                        eivarausta = true;

                }
                if (eivarausta == true) {
                    cout << "Varauksia ei lˆytynyt.\n\n";
                    cout << "Paina ENTER jatkaaksesi.\n";
                    getchar();

                    lopetus = false;
                    break;
                }
            }
            else if (onko_varauksia == false) {
                cout << "Ei varauksia.\n";
                cout << "Paina ENTER jatkaaksesi.\n";
                cin.clear();
                cin.ignore();
                getchar();
                lopetus = false;
                break;
            }


        case 4:
            cout << "Kiitos k‰ynnist‰!";
            lopetus = true; // Suljetaan ohjelma
            break;

        default:
            break;

        }


    }
}

int varausnumeroarvonta() // Aliojelma arpoo satunnaisen varausnumeron
{
    random_device random;
    mt19937 rng(random());
    uniform_int_distribution<mt19937::result_type> luku(10000, 999999);

    return luku(rng);

}

double alennusarvonta() // Aliohjelma alennuksen suuruuden arpomiseen
{
    int b;
    double a;

    b = rand() % 3 + 1; // rand() toimii hyvin pienten lukujen arvontaan

    switch (b) {
    case 1:
        a = 1;
        break;
    case 2:
        a = 0.9;
        break;
    case 3:
        a = 0.8;
        break;
    default:
        break;
    }
    return a;

}

int huonemaara() { // Aliohjelma arpoo huoneiden parillisen m‰‰r‰n

    int a;
    do {
        random_device random;
        mt19937 rng(random());
        uniform_int_distribution<mt19937::result_type> luku(40, 300);
        a = luku(rng);
    } while (a % 2 == 0); // Tarkistetaan parillisuus

    return a;

}

int huonenro(int a, int b) { // Aliohjelma arpoo huoneen numeron

    if (a == 1) {
        random_device random;
        mt19937 rng(random());
        uniform_int_distribution<mt19937::result_type> luku(1, b / 2); // Arvotaan yksi yhden hengen huone joka varataan
        return luku(rng);
    }

    else if (a == 2) {
        random_device random;
        mt19937 rng(random());
        uniform_int_distribution<mt19937::result_type> luku(b / 2, b); // Arvotaan yksi kahden hengen huone joka varataan
        return luku(rng);
    }

}

bool varaus(bool a) { // Aliohjelma tarkistaa ettei huone ole varattu

    if (a == true)
        return true;
    if (a == false)
        return false;

}