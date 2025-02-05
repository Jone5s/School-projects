using System;

namespace EUMembers
{

    public class Country
    {
        public Country(
            string code,
            string name,
            int area,
            int population)
        {
            Code = code;
            Name = name;
            Area = area;
            Population = population;
        }

        // Getters only: can't set country code or name
        // after construction.
        public string Code { get; }
        public string Name { get; }

        private int _area;
        public int Area  // square kilometers
        {
            get => _area;

            set
            {
                if (value <= 0)
                {
                    throw new ArgumentOutOfRangeException(
                        "Area",
                        "Area must be positive"
                    );
                }
                _area = value;
            }
        }

        private int _population;
        public int Population
        {
            get => _population;

            set
            {
                if (value <= 0)
                {
                    throw new ArgumentOutOfRangeException(
                        "Population",
                        "Population must be positive"
                    );
                }
                _population = value;
            }
        }

        internal object Where(Func<object, object> p)
        {
            throw new NotImplementedException();
        }

        // People per square kilometer. Integer division
        // should be good enough here.
        public int PopulationDensity => Population / Area;

        #region IEuropeanUnionMember interface implementation

        public bool IsCurrentMember => Exited == null;

        public bool IsFoundingMember =>
            Joined.Year == IEuropeanUnionMember.FoundingYear;

        public DateOnly Joined { get; set; }

        internal object Count(Func<object, object> p)
        {
            throw new NotImplementedException();
        }

        public DateOnly? Euro { get; set; }
        public DateOnly? Schengen { get; set; }
        public DateOnly? Exited { get; set; }
        public object JoinDate { get; internal set; }
        public bool InSchengen { get; internal set; }

        #endregion
    }

}