#include "Kalenterimerkinta.h"
#include <iostream>
using std::string;
using std::cout;

Kalenterimerkinta::Kalenterimerkinta()
{
	asia = "";
	muistutus = false;

}

Kalenterimerkinta::Kalenterimerkinta(int aPaiva, int aKuukausi, int aVuosi ,string aAsia,bool aMuistutus)
	: asia(aAsia),muistutus(aMuistutus)
{
	paivays.setPaivays(aPaiva, aKuukausi, aVuosi);
	cout << "Loudaan merkinta\n";
}

Kalenterimerkinta::~Kalenterimerkinta()
{
	cout << "Tuhotaan merkinta\n";
}

Kalenterimerkinta::Kalenterimerkinta(const Kalenterimerkinta& aMerkinta)
	:asia(aMerkinta.asia), muistutus(aMerkinta.muistutus)
{
	int aPaiva, aKk, aVuosi, valinta;
	cout << "Syota paiva: ";
	cin >> aPaiva;
	paivays.setPaiva(aPaiva);
	cout << "\nSyota kuukausi: ";
	cin >> aKk;
	paivays.setKuukausi(aKk);
	cout << "\nSyota vuosi: ";
	cin >> aVuosi;
	paivays.setVuosi(aVuosi);

	cout << "Merkinta kopiotiin\n";
}


void Kalenterimerkinta::tulostaMerkinta() const {
	cout << "Paivana " << paivays.getPaiva() << "." << paivays.getKuukausi() << "." << paivays.getVuosi() << "\n" << asia << " " << muistutus << "\n";
}

void Kalenterimerkinta::setAsia(string aAsia)
{
	asia = aAsia;
}

string Kalenterimerkinta::getAsia()
{
	return asia;
}

void Kalenterimerkinta::setMuistutus(bool aMuistutus)
{
	muistutus = aMuistutus;
}

bool Kalenterimerkinta::getMuistutus()
{
	return muistutus;
}

void Kalenterimerkinta::setMerkinta(int aPaiva, int aKuukausi, int aVuosi, string aAsia, bool aMuistutus) {
	
	paivays.setPaivays(aPaiva, aKuukausi, aVuosi);
	asia = aAsia;
	muistutus = aMuistutus;
}

void Kalenterimerkinta::kysyTiedot()
{
	int aPaiva, aKk, aVuosi, valinta;
	cout << "Syota paiva: ";
	cin >> aPaiva;
	paivays.setPaiva(aPaiva);
	cout << "\nSyota kuukausi: ";
	cin >> aKk;
	paivays.setKuukausi(aKk);
	cout << "\nSyota vuosi: ";
	cin >> aVuosi;
	paivays.setVuosi(aVuosi);

}
