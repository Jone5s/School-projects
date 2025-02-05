#pragma once
#include <string>
#include "Osoite.h"

using namespace std;

class Henkilo{
public:

	Henkilo(string aNimi, int aIka, string aKatu, string aPostinumero, string aKunta);
	Henkilo(string aNimi, int aIka);
	Henkilo(string aNimi, int aIka, Osoite aOsoite);
	Henkilo();
	~Henkilo();

	Henkilo(const Henkilo& aHenkilo);

	void setIka(int aIka);
	int getIka() const;
	void setNimi(string aNimi);
	string getNimi() const;
	void setOsoite(string aKatu, string aPostinro, string aKunta);
	Osoite getOsoite() const;
	void tervehdi() const;
	void tulostaTiedot() const;
protected:
	string nimi;
	int ika;
	Osoite osoite;
};
