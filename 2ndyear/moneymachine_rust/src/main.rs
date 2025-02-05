use std::fmt;

/// Represents a monetary amount in euros and cents.
struct AmountError {
    message: String,
}

impl AmountError {
    fn new(message: &str) -> Self {
        AmountError {
            message: message.to_string(),
        }
    }
}

impl fmt::Display for AmountError {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "{}", self.message)
    }
}

// Amount-tyypin määritteleminen
#[derive(Debug, PartialEq)]
struct Amount {
    euros: u32,
    cents: u32,
}

impl Amount {
    // Rakentajafunktio new_from, joka ottaa parametreina eurot ja sentit
    fn new_from(euros: u32, cents: u32) -> Result<Self, AmountError> {
        if cents > 99 {
            // Jos sentit eivät ole välillä 0 ... 99, palautetaan virhe
            return Err(AmountError::new("Virhe: sentit voivat olla vain välillä 0 ... 99"));
        }

        // Muuten luodaan uusi Amount-arvo annetuilla parametreilla
        Ok(Amount { euros, cents })
    }

    fn increment(&mut self) {
        if self.cents == 99 {
            self.cents = 0;
            self.euros += 1;
        } else {
            self.cents += 1;
        }
    }

    // Vähentää yhden eurosentin rahamäärästä
    fn decrement(&mut self) {
        if self.cents == 0 {
            self.cents = 99;
            self.euros -= 1;
        } else {
            self.cents -= 1;
        }
    }
}

// Custom Display trait implementation for Amount
impl fmt::Display for Amount {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "{}.{:02} \u{20AC}", self.euros, self.cents)
    }
}

impl Amount {
    /// Makes a new amount from cents
    fn new(cents: u32) -> Self {
        Amount {
            euros: cents / 100,
            cents: cents % 100
        }
    }
    
    /// Gets the amount as cents
    fn as_cents(&self) -> u32 {
        self.euros * 100 + self.cents
    }
}

impl Default for Amount {
    fn default() -> Self {
        Amount { euros: 0, cents: 0 }
    }
}
/// Euro coins
enum Coin {
    Cent1,
    Cent2,
    Cent5,
    Cent10,
    Cent20,
    Cent50,
    Eur1,
    Eur2,
}

impl Coin {
    /// Gets the monetary value of this coin in cents.
    fn value_in_cents(&self) -> u32 {
        match self {
            Coin::Cent1 => 1,
            Coin::Cent2 => 2,
            Coin::Cent5 => 5,
            Coin::Cent10 => 10,
            Coin::Cent20 => 20,
            Coin::Cent50 => 50,
            Coin::Eur1 => 100,
            Coin::Eur2 => 200 
        }    
    }
}

fn main() {
    // Make an amount with euros and cents
    let amount = Amount { euros: 2, cents: 57 };
    println!("{}", amount);

    // Make a new amount with cents only 
    let new_amount = Amount::new(586);
    println!("{}", new_amount);

    // Make a coin
    let twenty_cents = Coin::Cent20;
    println!("{}", twenty_cents.value_in_cents());

    // Make an array of coins
    let my_coins = [Coin::Cent20, Coin::Cent5, Coin::Cent10];

    // Sum up the values of the coins
    let mut sum = 0;
    for coin in my_coins.iter() {
        sum += coin.value_in_cents();
    }

    // Make an amount from the total coin value
    // and show it (implicitly using the Display trait) 
    let my_fortune = Amount::new(sum);
    println!("My fortune = {}", my_fortune);

    let my_fortune = Amount::default();
    println!("Default = {}", my_fortune);

    let bad_amount = Amount::new_from(3, 400); // huom. epäkelpo senttiarvo!

    match bad_amount {
        Ok(amount) => println!("hyvin meni : {}", amount),
        Err(error) => println!("ei onnistu : {}", error),
    }

    let good_amount = Amount::new_from(3, 90); // huom. epäkelpo senttiarvo!

    match good_amount {
        Ok(amount) => println!("hyvin meni : {}", amount),
        Err(error) => println!("ei onnistu : {}", error),
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_increment_normal() {
        let mut amount = Amount { euros: 3, cents: 45 };
        amount.increment();
        assert_eq!(amount, Amount { euros: 3, cents: 46 });
    }

    #[test]
    fn test_increment_euro_limit() {
        let mut amount = Amount { euros: 9, cents: 99 };
        amount.increment();
        assert_eq!(amount, Amount { euros: 10, cents: 0 });
    }

    #[test]
    fn test_decrement_normal() {
        let mut amount = Amount { euros: 2, cents: 30 };
        amount.decrement();
        assert_eq!(amount, Amount { euros: 2, cents: 29 });
    }

    #[test]
    fn test_decrement_euro_limit() {
        let mut amount = Amount { euros: 1, cents: 0 };
        amount.decrement();
        assert_eq!(amount, Amount { euros: 0, cents: 99 });
    }
}