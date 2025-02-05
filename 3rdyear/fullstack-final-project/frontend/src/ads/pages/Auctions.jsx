import { useQuery } from "react-query";

import { getAuctions } from "../api/cars";

import AuctionsList from "../components/AuctionList";
import LoadingSpinner from "../../shared/components/LoadingSpinner";

const Auctions = () => {
  const { isLoading, error, data } = useQuery("auctionsData", getAuctions);

  if (isLoading) {
    return (
      <div className="center">
        <LoadingSpinner />
      </div>
    );
  }

  if (error) {
    return "An error has occurred: " + error.message;
  }

  return (
    <>
      <AuctionsList items={data} />
    </>
  )
};

export default Auctions;
