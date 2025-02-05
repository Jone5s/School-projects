#pragma once
#include "Henkilo.h"
#include <vector>
class Opiskelija : public Henkilo
{
public:
	Opiskelija();
	Opiskelija(const string& aNimi, int aIka, const Osoite& aOsoite, const string& aOpNro);
	~Opiskelija();
	void lisaaKurssi();
	void tulostaTiedot() const;
	int getOpintopisteet() const;
	void setOpintopusteet(int aOp);
	void lisaaOpintopisteita(int aOp);

protected:
	string opNro;
	vector<string> suoritetutKurssit;
	int opintopisteet = 0;
};

