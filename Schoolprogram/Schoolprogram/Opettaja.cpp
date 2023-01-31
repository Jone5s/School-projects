#include "Opettaja.h"
#include <iostream>
#include <string>
using namespace std;

Opettaja::Opettaja()
{
	cout << "Opettaja -luokan oletusrakentaja\n";
}

Opettaja::Opettaja(const string& aNimi, int aIka, const Osoite & aOsoite, const string& aKoulutusala)
	: Henkilo(aNimi, aIka, aOsoite), koulutusala(aKoulutusala)
{
	cout << "Opettaja -luokan rakentaja " << endl;
}

Opettaja::~Opettaja()
{
	cout << "Opettaja -luokan purkaja" << endl;
}

void Opettaja::setKoulutusala(const string& aKoulutusala)
{
	koulutusala = aKoulutusala;
}

string Opettaja::getKoulutusala() const
{
	return koulutusala;
}

void Opettaja::lisaaKurssi()
{
	string aKurssi;
	cout << "Syota kurssin nimi: ";
	cin.ignore();
	getline(cin, aKurssi);
	kurssit.push_back(aKurssi);
}

void Opettaja::tulostaTiedot() const
{
	cout << "Opettajan tiedot:" << endl;
	cout << getNimi() << endl;
	cout << "ika: " << getIka() << endl;
	cout << "Osoite:";
	getOsoite().tulostaTiedot();
	cout << "Koulutusala: " << koulutusala << endl;
	for (string s : kurssit) {
		cout << s << endl;
	}
}
