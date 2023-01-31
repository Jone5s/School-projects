#pragma once
#include<string>
using std::string;


class Osoite
{
public:
	Osoite();
	Osoite(string aKatu, string aPostinumero, string aKunta);

	void setKatu(string aKatu);
	string getKatu() const;
	string getPostinro() const;
	string getKunta() const;
	
	void setOsoite(string aKatu, string aPostinro, string aKunta);

	void tulostaTiedot() const;

private:
	string mKatu;
	string mPostinumero;
	string mKunta;
	
};
