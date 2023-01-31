#include "Opiskelija.h"
#include <iostream>
#include <string>
using namespace std;
Opiskelija::Opiskelija()
{
	cout << "Opiskelija -luokan oletusrakenta\n";
}
Opiskelija::Opiskelija(const string& aNimi, int aIka, const Osoite& aOsoite, const string& aOpNro)
	: Henkilo(aNimi, aIka, aOsoite), opNro(aOpNro)
{
	cout << "Opiskelija -luokan rakentaja\n";
}

Opiskelija::~Opiskelija()
{
	cout << "Opiskelija -luokan purkaja\n";
}

void Opiskelija::lisaaKurssi()
{
	string aKurssi;
	cout << "Lisataan opiskelijalle suoritettu kurssi. \nSyota kurssin nimi: ";
	cin.ignore();
	getline(cin, aKurssi);
	suoritetutKurssit.push_back(aKurssi);
}

void Opiskelija::tulostaTiedot() const
{
	cout << "Opiskelijan tiedot:" << endl;
	cout << getNimi() << endl;
	cout << "ika: " << getIka() << endl;
	cout << "Osoite:";
	getOsoite().tulostaTiedot();
	cout << "Opiskelijanumero: " << opNro << endl;
	cout << "Opintopisteet: " << opintopisteet << endl;
	for (string s : suoritetutKurssit) {
		cout << s << endl;
	}
}

int Opiskelija::getOpintopisteet() const
{
	return opintopisteet;
}

void Opiskelija::setOpintopusteet(int aOp)
{
	opintopisteet = aOp;
}

void Opiskelija::lisaaOpintopisteita(int aOp)
{
	opintopisteet += aOp;
	
}
