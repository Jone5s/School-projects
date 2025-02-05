#include <iostream>
#include <string>
#include "Kalenterimerkinta.h"
#include "Henkilo.h"
#include "Opettaja.h"
#include "Opiskelija.h"
#include "Koulu.h"
#include <vector>
using namespace std;

int main() {
	
	Koulu koulu("TAMK");  // Ohjelma toimii käytännössä kokonaan Koulu-luokassa ja sen alaluokissa.
	int valinta;
	bool lopetus = false;
	while (lopetus == false) {  // Päävalikko ohjelmalle
		cout << "Tervetuloa kouluun!\nValitse toiminto:\n1. Lisaa opettaja\n2. Lisaa opettajalle kurssi\n3. Lisaa Opiskelija\n4. Lisaa opiskelijalle suoritettu kurssi\n5. Tulosta opettajat\n6. Tulosta opiskelijat\n7. Tulosta koulun kaikki tiedot\n8. Lopeta\n";
		cin >> valinta;
		if (valinta == 1) 
		koulu.lisaaOpettaja();
		if (valinta == 2)
		koulu.lisaaOpettajalleKurssi();
		if (valinta == 3)
		koulu.lisaaOpiskelija();
		if (valinta == 4)
		koulu.lisaaOpiskelijalleKurssi();
		if (valinta == 5)
		koulu.tulostaOpettajat();
		if (valinta == 6)
		koulu.tulostaOpiskelijat();
		if (valinta == 7)
		koulu.tulostaKaikkiTiedot();
		if (valinta == 8)
			lopetus = true;
	}

	return 0;
}
