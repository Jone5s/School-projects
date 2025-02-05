#pragma once
#include <string>

using namespace std;

class Paivays {
public:
	Paivays();
	Paivays(int aPaiva, int aKk, int aVuosi);
	~Paivays();
	void setPaiva(int aPaiva);
	int getPaiva() const;
	void setVuosi(int aVuosi);
	int getVuosi() const;
	void setKuukausi(int aKk);
	int getKuukausi() const;
	void tulostaPaivays();
	void setPaivays(int aPaiva, int aKk, int aVuosi);
	void lisaaPaiva();
private:
	int paiva, kuukausi, vuosi;
};

