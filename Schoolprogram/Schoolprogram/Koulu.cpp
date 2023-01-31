#include "Koulu.h"
#include <iostream>

Koulu::Koulu(string aNimi)
{
	nimi = aNimi;
	cout << "Koulu -luokan rakentaja\n";
}

Koulu::Koulu()
{
	cout << "Syota koulun nimi: ";
	cin >> nimi;

}

Koulu::~Koulu()
{
	cout << "Koulu -luokan purkaja\n";
}

void Koulu::setNimi(string aNimi)
{
	nimi = aNimi;
}

string Koulu::getNimi()
{
	return nimi;
}

void Koulu::lisaaOpiskelija()
{
	string aNimi,aKatu,aPostinumero,aKunta,aOpiskelijanumero;
	int aIka;
	cout << "Lisataan opiskelija\nSyota opiskelijan nimi: ";
	cin.ignore();
	getline(cin, aNimi);
	cout << "Syota opiskelijan ika: ";
	cin >> aIka;
	cout << "Syota opiskelijan osoite: \nKatu: ";
	cin.ignore();
	getline(cin, aKatu);
	cout << "Postinumero: ";
	cin.ignore();
	getline(cin, aPostinumero);
	cout << "Kunta: ";
	cin.ignore();
	getline(cin, aKunta);
	cout << "Syota opiskelijan opiskelijanumero: ";
	cin.ignore();
	cin >> aOpiskelijanumero;

	Osoite aOsoite(aKatu, aPostinumero, aKunta);
	Opiskelija aOpiskelija(aNimi,aIka,aOsoite,aOpiskelijanumero);
	
	opiskelijat.push_back(aOpiskelija);
}

void Koulu::lisaaOpettaja()
{
	string aNimi, aKatu, aPostinumero, aKunta, aKoulutusala;
	int aIka;
	cout << "Lisataan opettaja.\nSyota opettajan nimi: ";
	cin.ignore();
	getline(cin,aNimi);
	cout << "Syota opettajan ika: ";
	cin >> aIka;
	cin.ignore();
	cout << "Syota opettajan osoite: \nKatu: ";
	getline(cin, aKatu);
	cout << "Postinumero: ";
	cin.ignore();
	getline(cin, aPostinumero);
	cout << "Kunta: ";
	cin.ignore();
	getline(cin, aKunta);
	cout << "Syota opettajan koulutusala: ";
	cin.ignore();
	getline(cin, aKoulutusala);


	Osoite aOsoite(aKatu, aPostinumero, aKunta);
	Opettaja aOpettaja(aNimi, aIka, aOsoite, aKoulutusala);

	opettajat.push_back(aOpettaja);
}

void Koulu::tulostaOpettajat() const
{
	for (Opettaja i : opettajat)
		i.tulostaTiedot();
}

void Koulu::tulostaOpiskelijat() const
{
	for (Opiskelija i : opiskelijat)
		i.tulostaTiedot();
}

void Koulu::tulostaKaikkiTiedot() const
{
	int opettajaLkm = 0, opiskelijaLkm = 0;
	cout << "Koulun nimi: " << nimi << endl;
	for (Opiskelija i : opiskelijat)
		opiskelijaLkm++;
	for (Opettaja i : opettajat)
		opettajaLkm++;
	cout << "Opettajien lukumaara: " << opettajaLkm << endl;
	cout << "Opiskelijoiden lukumaara: " << opiskelijaLkm << endl;
	cout << "Opettajat: \n";
	for (Opettaja i : opettajat)
		i.tulostaTiedot();
	cout << "Opiskelijat: \n";
	for (Opiskelija i : opiskelijat)
		i.tulostaTiedot();
}

void Koulu::lisaaOpettajalleKurssi()
{
	int valinta;
	cout << "Monennellekko opettajalle haluat lisata kurssin?";
	cin >> valinta;
	opettajat[valinta-1].lisaaKurssi();
}

void Koulu::lisaaOpiskelijalleKurssi()
{
	int aOp,valinta;
	cout << "Monennellekko opiskelijalle haluat lisata suoritetun kurssin?";
	cin >> valinta;
	opiskelijat[valinta-1].lisaaKurssi();
	cout << "Syota kurssin opintopistemaara: ";
	cin >> aOp;
	opiskelijat[valinta-1].lisaaOpintopisteita(aOp);
}
