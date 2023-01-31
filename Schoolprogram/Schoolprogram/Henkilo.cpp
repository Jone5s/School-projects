#include "Henkilo.h"
#include <iostream>
#include <string>
using namespace std;


Henkilo::Henkilo(const Henkilo& aHenkilo) 
	: nimi(aHenkilo.nimi), ika(aHenkilo.ika), osoite(aHenkilo.osoite)
{
	cout << "Kopioidaan " << aHenkilo.nimi << endl;
}

void Henkilo::setIka(int aIka) {
	ika = aIka;
}
int Henkilo::getIka() const {
	return ika;
}
void Henkilo::setNimi(string aNimi) {
	nimi = aNimi;
}
string Henkilo::getNimi() const {
	return nimi;
}
Osoite Henkilo::getOsoite() const
{
	return osoite;
}

void Henkilo::setOsoite(string aKatu, string aPostinro, string aKunta)
{
	osoite.setOsoite(aKatu, aPostinro, aKunta);
}

void Henkilo::tervehdi() const {
	cout << "Olen " << nimi << " ja olen " << ika << " vuotias." << endl;
	cout << "Osoitteeni on " << osoite.getKatu() << " , " << osoite.getPostinro() << " , " << osoite.getKunta() << endl;
}

void Henkilo::tulostaTiedot() const
{
	cout << "Olen " << nimi << " ja olen " << ika << " vuotias." << endl;
	cout << "Osoitteeni on " << osoite.getKatu() << " , " << osoite.getPostinro() << " , " << osoite.getKunta() << endl;
}

Henkilo::Henkilo(string aNimi, int aIka, string aKatu, string aPostinumero, string aKunta) {
	nimi = aNimi;
	ika = aIka;
	osoite.setOsoite(aKatu, aPostinumero, aKunta);
}

Henkilo::Henkilo(string aNimi, int aIka) {
	nimi = aNimi;
	ika = aIka;
	cout << "'Henkilo -luokan rakentaja\n";
}

Henkilo::Henkilo(string aNimi, int aIka, Osoite aOsoite)
	:nimi(aNimi),ika(aIka),osoite(aOsoite)
{
}

Henkilo::Henkilo() {
	nimi = "";
	ika = 0;
}

Henkilo::~Henkilo()
{
	cout << "'Henkilo' luokan purkaja\n";
}

