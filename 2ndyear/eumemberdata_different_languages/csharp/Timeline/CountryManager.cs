using System;
using System.Collections.Generic;
using System.Linq;

namespace EUMembers{

public sealed class CountryManager
{
    // The singleton instance is private.
    private static readonly CountryManager instance = new CountryManager();

    // Explicit static constructor to tell the C# compiler
    // not to mark the type as `beforefieldinit`.
    // See https://csharpindepth.com/articles/singleton
    static CountryManager() { }

    // The constructor is private to prevent instantiation.
    private CountryManager()
    {
        // Initialize the basic country data.
        _countries = new List<Country> {
            new Country("AT", "Austria", 83_879, 9_027_999),
            new Country("BE", "Belgium", 30_528, 11_584_008),
            new Country("BG", "Bulgaria", 111_002, 6_520_314),
            new Country("CY", "Cyprus", 9251, 1_244_188),
            new Country("CZ", "Czechia", 78867, 10_524_167),
            new Country("DE", "Germany", 357340, 83_695_430),
            new Country("DK", "Denmark", 42_921, 5_910_577),
            new Country("EE", "Estonia", 45_227, 1_331_824),
            new Country("EL", "Greece", 131_957, 10_432_481),
            new Country("ES", "Spain", 505_970, 47_450_795),
            new Country("FI", "Finland", 338_472, 5_559_521),
            new Country("GB", "Great Britain", 243_610, 67_791_000),
            new Country("FR", "France", 632_833, 67_897_000),
            new Country("HR", "Croatia", 56_594, 3_888_529),
            new Country("HU", "Hungary", 93_024, 9_749_763),
            new Country("IE", "Ireland", 69_797, 5_123_536),
            new Country("IT", "Italy", 302_073, 58_983_000),
            new Country("LT", "Lithuania", 65_300, 2_832_718),
            new Country("LU", "Luxembourg", 2_586, 645_397),
            new Country("LV", "Latvia", 64_573, 1_907_675),
            new Country("MT", "Malta", 316, 519_562),
            new Country("NL", "Netherlands", 41_540, 17_740_000),
            new Country("PL", "Poland", 312_679, 38_179_800),
            new Country("PT", "Portugal", 92_225, 10_344_802),
            new Country("RO", "Romania", 238_391, 19_038_098),
            new Country("SE", "Sweden", 438_574, 10_481_937),
            new Country("SK", "Slovakia", 49_035, 5_460_185),
            new Country("SI", "Slovenia", 20_273, 2_108_708)
        };

        // Important EU dates for the countries. The date strings will be
        // parsed into DateOnly object instances.
        // Modeled after the example found at
        // https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/builtin-types/value-tuples
        var allDates = new Dictionary<string, (string, string, string, string)>()
        {
            ["AT"] = ("1995-01-01", "1999-01-01", "2007-12-01", string.Empty),
            ["BE"] = ("1958-01-01", "1999-01-01", "1995-03-26", string.Empty),
            ["BG"] = ("2007-01-01", string.Empty, string.Empty, string.Empty),
            ["HR"] = ("2013-07-01", "2023-01-01", "2023-01-01", string.Empty),
            ["CY"] = ("2004-05-01", "2008-01-01", string.Empty, string.Empty),
            ["CZ"] = ("2004-05-01", string.Empty, "2007-12-21", string.Empty),
            ["DK"] = ("1973-01-01", string.Empty, "2001-03-25", string.Empty),
            ["EE"] = ("2004-01-01", "2011-01-01", "2007-12-21", string.Empty),
            ["FI"] = ("1995-01-01", "1999-01-01", "2001-03-25", string.Empty),
            ["FR"] = ("1958-01-01", "1999-01-01", "1995-03-26", string.Empty),
            ["DE"] = ("1958-01-01", "1999-01-01", "1995-03-26", string.Empty),
            ["EL"] = ("1981-01-01", "2001-01-01", "2000-01-01", string.Empty),
            ["HU"] = ("2004-01-01", string.Empty, "2007-12-21", string.Empty),
            ["IE"] = ("1973-01-01", "1999-01-01", string.Empty, string.Empty),
            ["IT"] = ("1958-01-01", "1999-01-01", "1997-10-26", string.Empty),
            ["LV"] = ("2004-05-01", "2014-01-01", "2007-12-21", string.Empty),
            ["LT"] = ("2004-05-01", "2015-01-01", "2007-12-21", string.Empty),
            ["LU"] = ("1958-01-01", "1999-01-01", "1995-03-26", string.Empty),
            ["MT"] = ("2004-05-01", "2008-01-01", "2007-12-21", string.Empty),
            ["NL"] = ("1958-01-01", "1999-01-01", "1995-03-26", string.Empty),
            ["PL"] = ("2004-05-01", string.Empty, "2007-12-21", string.Empty),
            ["PT"] = ("1986-01-01", "1999-01-01", "1995-03-26", string.Empty),
            ["RO"] = ("2007-01-01", string.Empty, string.Empty, string.Empty),
            ["SK"] = ("2004-05-01", "2009-01-01", "2007-12-21", string.Empty),
            ["SI"] = ("2004-05-01", "2007-01-01", "2007-12-21", string.Empty),
            ["ES"] = ("1986-01-01", "1999-01-01", "1995-03-26", string.Empty),
            ["SE"] = ("1995-01-01", string.Empty, "2001-03-25", string.Empty),
            ["GB"] = ("1973-01-01", string.Empty, string.Empty, "2020-01-31"),
        };

        // Tuple items are accessed with Item1, Item2 etc.

        // Set the date properties of the countries.
        // If the date string is not empty, we parse it into a LocalDate.
        // Empty strings result in null values for the date.
        // Careful: parsing will fail if the string is not in the right format.
        foreach (var countryCode in allDates.Keys)
        {
            var country = this.GetCountryByCode(countryCode)!;
            var dates = allDates[countryCode];
            country.Joined = DateOnly.Parse(dates.Item1); // only this date is never null
            country.Euro = string.IsNullOrEmpty(dates.Item2) ? null : DateOnly.Parse(dates.Item2);
            country.Schengen = string.IsNullOrEmpty(dates.Item3) ? null : DateOnly.Parse(dates.Item3);
            country.Exited = string.IsNullOrEmpty(dates.Item4) ? null : DateOnly.Parse(dates.Item4);
        }
    }

    // The singleton instance is a public read-only property.
    public static CountryManager Instance => instance;

    // The country list is kept in a private List<Country> instance.
    // It is exposed to clients through a read-only list, so nobody
    // outside this class can change it.
    private List<Country> _countries;

        public IReadOnlyList<Country> Countries => _countries;

    // Looks up a country based on its standard country code.
    public Country? GetCountryByCode(string code)
    {
        if (code.Length != 2 || code != code.ToUpper())
        {
            throw new ArgumentException("Invalid country code");
        }

        // The default value for a reference is null,
        // so FirstOrDefault returns null if no element
        // is found matching the predicate.
        return _countries.FirstOrDefault(c => c.Code.Equals(code));
    }
}
}