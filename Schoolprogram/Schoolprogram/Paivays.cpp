#include "Paivays.h"
#include <iostream>
#include <string>
using namespace std;


Paivays::Paivays()
{
}

Paivays::Paivays(int aPaiva, int aKk, int aVuosi)
	: paiva(aPaiva), kuukausi(aKk), vuosi(aVuosi)
{
}

Paivays::~Paivays()
{
}

void Paivays::setPaiva(int aPaiva) {
	paiva = aPaiva;
}
int Paivays::getPaiva() const {
	return paiva;
}

void Paivays::setKuukausi(int aKk) {
	kuukausi = aKk;
}
int Paivays::getKuukausi() const {
	return kuukausi;
}

void Paivays::setVuosi(int aVuosi) {
	vuosi = aVuosi;
}
int Paivays::getVuosi() const {
	return vuosi;
}

void Paivays::tulostaPaivays() {
	cout << paiva << "." << kuukausi << "." << vuosi << endl;
}

void Paivays::setPaivays(int aPaiva, int aKk, int aVuosi) {
	paiva = aPaiva;
	kuukausi = aKk;
	vuosi = aVuosi;
}

void Paivays::lisaaPaiva() {
	paiva++;
	if (paiva > 31) { 
		kuukausi++;
		paiva = 1;

		if (kuukausi > 12) {
			vuosi++;
			kuukausi = 1;
		}
	}
}

