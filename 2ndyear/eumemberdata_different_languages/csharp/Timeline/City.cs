using System;

namespace EUMembers { 

public class City
{
    public string Name;
    public Coordinates Location;

    public City(string name, Coordinates location)
    {
        Name = name;
        Location = location;
    }

    public override string ToString()
    {
        return string.Format("{0} @ {1}", Name, Location);
    }

    public double DistanceTo(City other)
    {
        double DegreesToRadians(double degrees)
        {
            return (Math.PI / 180) * degrees;
        }

        const double EarthEquatorialRadius = 6378.1370;  // km

        double lat1 = DegreesToRadians(this.Location.Latitude);
        double lon1 = DegreesToRadians(this.Location.Longitude);

        double lat2 = DegreesToRadians(other.Location.Latitude);
        double lon2 = DegreesToRadians(other.Location.Longitude);

        double dlon = lon2 - lon1;
        double dlat = lat2 - lat1;

        double a = Math.Pow(Math.Sin(dlat / 2), 2)
            + Math.Cos(lat1) * Math.Cos(lat2)
            * Math.Pow(Math.Sin(dlon / 2), 2);

        double c = 2 * Math.Atan2(Math.Sqrt(a), Math.Sqrt(1 - a));

        return EarthEquatorialRadius * c;
    }
}
}