#pragma once
#include<string>
#include "Paivays.h"
using std::string;
class Kalenterimerkinta
{
public:
	Kalenterimerkinta();
	Kalenterimerkinta(int aPaiva,int aKuukausi,int aVuosi,string aAsia,bool aMuistutus);
	~Kalenterimerkinta();

	Kalenterimerkinta(const Kalenterimerkinta& aMerkinta);

	void setAsia(string aAsia);
	string getAsia();
	void setMuistutus(bool aMuistutus);
	bool getMuistutus();
	void setMerkinta(int aPaiva, int aKuukausi, int aVuosi,string aAsia,bool aMuistutus);
	void kysyTiedot();

	void tulostaMerkinta() const;

private:
	Paivays paivays;
	string asia;
	bool muistutus;
};

