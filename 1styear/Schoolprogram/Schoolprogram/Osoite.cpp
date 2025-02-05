#include "Osoite.h"
#include <iostream>
using std::string;
using std::cout;

Osoite::Osoite()
{

}

Osoite::Osoite(string aKatu, string aPostinumero, string aKunta)
	: mKatu(aKatu), mPostinumero(aPostinumero), mKunta(aKunta)
{

}

void Osoite::setOsoite(string aKatu, string aPostinro, string aKunta)
{
	mKatu = aKatu;
	mPostinumero = aPostinro;
	mKunta = aKunta;
}

void Osoite::setKatu(string aKatu)
{
	mKatu = aKatu;
}

string Osoite::getKatu() const
{
	return mKatu;
}

string Osoite::getPostinro() const
{
	return mPostinumero;
}

string Osoite::getKunta() const
{
	return mKunta;
}


void Osoite::tulostaTiedot() const
{
	std::cout << mKatu << "\nPostinumero: " << mPostinumero << "\nKunta: " << mKunta << "\n";
}
