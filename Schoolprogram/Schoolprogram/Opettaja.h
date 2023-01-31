#pragma once
#include "Henkilo.h"
#include <vector>
#include <string>
using namespace std;
class Opettaja : public Henkilo
{
public:
	Opettaja();
	Opettaja(const string& aNimi, int aIka, const Osoite& aOsoite, const string& aKoulutusala);
	~Opettaja();
	void setKoulutusala(const string& aKoulutusala);
	string getKoulutusala() const;
	void lisaaKurssi();
	void tulostaTiedot() const;
private:
	string koulutusala;
	vector<string> kurssit;
};

