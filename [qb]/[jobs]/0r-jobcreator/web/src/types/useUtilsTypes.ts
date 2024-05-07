export interface PaginationProps {
  selected: number;
}

export type vector4Type = {
  x: string | number;
  y: string | number;
  z: string | number;
  h?: string | number;
};

export type CarSpawnerCarProps = {
  model: string;
};

export type MarketItemProps = {
  item_name: string;
  label: string;
  type: "sell" | "buy";
  amount: number;
  money_type: "cash" | "bank";
  price: number;
};
