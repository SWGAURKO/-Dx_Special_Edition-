import { HTMLInputTypeAttribute } from "react";
import {
  CarSpawnerCarProps,
  MarketItemProps,
  vector4Type,
} from "./useUtilsTypes";

export type ReactChildren = { children: React.ReactNode };

export type JobInputProps = {
  type: HTMLInputTypeAttribute;
  label: string;
  uniqueName: string;
  required: boolean;
  description: string;
  hintLink?: string;
  options?: {
    value: string | number;
    label: string;
  }[];
  showWhen?: (item: any) => boolean;
  className?: string;
  attributes?: { [key: string]: any };
};

export type JobProps = {
  [key: string]: any;
  id?: number;
  identity: string;
  name: string;
  unique_name: string;
  perm: {
    type: string;
    name?: string;
  };
  notify_type: string;
  progressbar_type: string;
  skillbar_type: string;
  menu_type: string;
  target_type: string;
  textui_type: string;
  author: string;
  status: "active" | "deactive";
  start_type?: "ped" | "always_active";
  blip?: {
    is_required?: "yes" | "no";
    scale?: number;
    sprite?: number;
    color?: number;
    name?: string;
  };
  start_ped?: {
    model?: string;
    coords?: vector4Type;
    interaction_type?: string;
  };
  steps: JobStepProps[];
  teleports: JobTeleportProps[];
  objects: JobObjectProps[];
  carSpawners: JobCarSpawnerProps[];
  stashes: JobStashProps[];
  markets: JobMarketProps[];
};

export type JobStepProps = {
  [key: string]: any;
  id: number;
  job_identity: string;
  title: string;
  cool_down: number;
  coords: vector4Type[];
  blip: {
    is_required: "yes" | "no";
    scale: number;
    sprite: number;
    color: number;
    name: string;
  };
  radius: number;
  interaction_type: "target" | "textui";
  required_item: {
    is_required: "yes" | "no";
    name: string;
    count: number;
  };
  animation: {
    is_required: "yes" | "no";
    name: string;
    dict: string;
    flags: number;
    duration: number;
    type: "skillbar" | "progressbar";
    progressbar: {
      title: string;
      disable_movement: "yes" | "no";
    };
    skillbar: {
      needed_attempts: number;
    };
    prop: {
      is_required: "yes" | "no";
      model: string;
      bone: number;
      coords: vector4Type;
      rotation: vector4Type;
    };
  };
  remove_item: {
    is_required: "yes" | "no";
    item_name: string;
    count: number;
  };
  give_item: {
    is_required: "yes" | "no";
    item_name: string;
    count: number;
  };
  give_money: {
    is_required: "yes" | "no";
    type: "bank" | "cash";
    amount: number;
    reason?: string;
  };
  remove_money: {
    is_required: "yes" | "no";
    type: "bank" | "cash";
    amount: number;
    reason?: string;
  };
  author: string;
};

export type JobTeleportProps = {
  [key: string]: any;
  id: number;
  job_identity: string;
  name: string;
  interaction_type: "target" | "textui";
  type: "one-way" | "two-way";
  entry_coords: vector4Type;
  exit_coords: vector4Type;
  author: string;
};

export type JobObjectProps = {
  [key: string]: any;
  id: number;
  job_identity: string;
  name: string;
  coords: vector4Type;
  type: "object" | "ped";
  model_hash: string;
  is_network: "yes" | "no";
  net_mission_entity: "yes" | "no";
  door_flag: "yes" | "no";
  author: string;
};

export type JobCarSpawnerProps = {
  [key: string]: any;
  id: number;
  job_identity: string;
  name: string;
  interaction_type: "target" | "textui";
  coords: vector4Type;
  car_spawner_coords: vector4Type;
  cars: CarSpawnerCarProps[];
  author: string;
};

export type JobStashProps = {
  [key: string]: any;
  id: number;
  job_identity: string;
  name: string;
  interaction_type: "target" | "textui";
  coords: vector4Type;
  size: number;
  slots: number;
  author: string;
};

export type JobMarketProps = {
  [key: string]: any;
  id: number;
  job_identity: string;
  name: string;
  interaction_type: "target" | "textui";
  ped_coords: vector4Type[];
  ped_model_hash: string;
  items: MarketItemProps[];
  author: string;
};
