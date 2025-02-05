using System;

namespace EUMembers { 

public class Coordinates
{
    private double _latitude;
    public double Latitude
    {
        get
        {
            return _latitude;
        }

        set
        {
            if (value >= -90 && value < 90)
            {
                _latitude = value;
            }
            else
            {
                throw new ArgumentOutOfRangeException(
                    "Latitude", "Must be [-90, 90)");
            }
        }
    }

    private double _longitude;
    public double Longitude
    {
        get
        {
            return _longitude;
        }

        set
        {
            if (value >= -180 && value < 180)
            {
                _longitude = value;
            }
            else
            {
                throw new ArgumentOutOfRangeException(
                    "Longitude", "Must be [-180, 180)");
            }
        }
    }

    public Coordinates(double latitude, double longitude)
    {
        Latitude = latitude;
        Longitude = longitude;
    }

    public override string ToString()
    {
        return string.Format("{0},{1}", Latitude, Longitude);
    }
}
}