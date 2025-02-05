#pragma once
#include <string>
#include "Henkilo.h"
#include "Opettaja.h"
#include "Opiskelija.h"
#include <vector>
class Koulu
{
public:

	Koulu(string aNimi);
	Koulu();
	~Koulu();

	void setNimi(string aNimi);
	string getNimi();
	void lisaaOpiskelija();
	void lisaaOpettaja();
	void tulostaOpettajat() const;
	void tulostaOpiskelijat() const;
	void tulostaKaikkiTiedot() const;
	void lisaaOpettajalleKurssi();
	void lisaaOpiskelijalleKurssi();
protected:
	string nimi;
	vector<Opiskelija> opiskelijat;
	vector<Opettaja> opettajat;
};

