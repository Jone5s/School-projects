using System;

namespace EUMembers
{

    public interface IEuropeanUnionMember
    {
        // Can declare constants in interfaces since C# 7:
        public const int FoundingYear = 1958;

        // Computed properties for member status
        public bool IsCurrentMember { get; }
        public bool IsFoundingMember { get; }

        // Stored properties to get important dates
        public DateOnly Joined { get; set; }
        public DateOnly? Euro { get; set; }
        public DateOnly? Schengen { get; set; }
        public DateOnly? Exited { get; set; }
    }
}
