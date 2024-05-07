import { JobInputProps, JobProps } from "../../types/JobTypes";

export const AddStepInputs = (Job: JobProps | undefined): JobInputProps[] => [
  {
    type: "number",
    label: "Radius",
    uniqueName: "radius",
    required: true,
    description: "The radius at which the work can be performed, (min 1.5) ",
    attributes: {
      min: 1.5,
      step: 0.01,
      max: 100.0,
    },
  },
  {
    type: "text",
    label: "Title",
    uniqueName: "title",
    required: true,
    description: "Short title describing the work step",
  },
  {
    type: "select",
    label: "Interaction Type",
    uniqueName: "interaction_type",
    required: true,
    description: "Job step interaction type",
    options: [
      { value: "", label: "" },
      {
        value: "target",
        label: `Target (${Job?.target_type})`,
      },
      {
        value: "textui",
        label: `Text UI (${Job?.textui_type})`,
      },
    ],
  },
  {
    type: "number",
    label: "Cool Down Time",
    uniqueName: "cool_down",
    required: true,
    description: "Cooling down time to do the same step again (in seconds)",
    attributes: {
      min: 1,
      max: 1400,
    },
  },
  {
    type: "select",
    label: "Blip",
    uniqueName: "blip.is_required",
    required: true,
    description: "Create a blip for this step",
    options: [
      { value: "", label: "" },
      { value: "yes", label: "Yes" },
      { value: "no", label: "No" },
    ],
  },
  {
    type: "number",
    label: "[Blip] Scale",
    uniqueName: "blip.scale",
    required: true,
    description: "Blip scale",
    showWhen(step) {
      return step.blip?.is_required === "yes";
    },
  },
  {
    type: "number",
    label: "[Blip] Sprite",
    uniqueName: "blip.sprite",
    required: true,
    description: "Blip sprite",
    hintLink: "https://docs.fivem.net/docs/game-references/blips/",
    showWhen(step) {
      return step.blip?.is_required === "yes";
    },
  },
  {
    type: "number",
    label: "[Blip] Color",
    uniqueName: "blip.color",
    required: true,
    description: "Blip color",
    hintLink: "https://docs.fivem.net/docs/game-references/blips/#blip-colors",
    showWhen(step) {
      return step.blip?.is_required === "yes";
    },
  },
  {
    type: "text",
    label: "[Blip] Name",
    uniqueName: "blip.name",
    required: true,
    description: "Blip name",
    showWhen(step) {
      return step.blip?.is_required === "yes";
    },
  },
  {
    type: "select",
    label: "Required Item",
    uniqueName: "required_item.is_required",
    required: true,
    description: "Item required to perform this step",
    options: [
      { value: "", label: "" },
      { value: "yes", label: "Yes" },
      { value: "no", label: "No" },
    ],
  },
  {
    type: "text",
    label: "[Required Item] Name",
    uniqueName: "required_item.name",
    required: true,
    description: "Required item name",
    showWhen(step) {
      return step.required_item?.is_required === "yes";
    },
  },
  {
    type: "number",
    label: "[Required Item] Count",
    uniqueName: "required_item.count",
    required: true,
    description: "Required item count",
    showWhen(step) {
      return step.required_item?.is_required === "yes";
    },
    attributes: {
      min: 1,
      max: 10000,
    },
  },
  {
    type: "select",
    label: "Animation",
    uniqueName: "animation.is_required",
    required: true,
    description: "Animation required to perform this step",
    options: [
      {
        label: "",
        value: "",
      },
      {
        label: "Yes",
        value: "yes",
      },
      {
        label: "No",
        value: "no",
      },
    ],
  },
  {
    type: "text",
    label: "[Animation] Name",
    uniqueName: "animation.name",
    required: true,
    description: "Animation name",
    hintLink: "https://gtahash.ru/animations/",
    showWhen(step) {
      return (
        step.animation?.is_required === "yes" &&
        step.animation?.type == "progressbar"
      );
    },
  },
  {
    type: "text",
    label: "[Animation] Dict",
    uniqueName: "animation.dict",
    required: true,
    description: "Animation dict",
    hintLink: "https://gtahash.ru/animations/",
    showWhen(step) {
      return (
        step.animation?.is_required === "yes" &&
        step.animation?.type == "progressbar"
      );
    },
  },
  {
    type: "number",
    label: "[Animation] Flags",
    uniqueName: "animation.flags",
    required: false,
    description: "Animation flags",
    showWhen(step) {
      return (
        step.animation?.is_required === "yes" &&
        step.animation?.type == "progressbar"
      );
    },
  },
  {
    type: "select",
    label: "[Animation] Type",
    uniqueName: "animation.type",
    required: true,
    description: "Animation type",
    options: [
      {
        label: "",
        value: "",
      },
      {
        label: `Skillbar (${Job?.skillbar_type})`,
        value: "skillbar",
      },
      {
        label: `Progressbar (${Job?.progressbar_type})`,
        value: "progressbar",
      },
    ],
    showWhen(step) {
      return step.animation?.is_required === "yes";
    },
  },
  {
    type: "number",
    label: "[Skillbar] Needed Attempts",
    uniqueName: "animation.skillbar.needed_attempts",
    required: true,
    description: "Skillbar needed attempts",
    showWhen(step) {
      return (
        step.animation?.is_required === "yes" &&
        step.animation?.type == "skillbar"
      );
    },
  },
  {
    type: "text",
    label: "[Progressbar] Title",
    uniqueName: "animation.progressbar.title",
    required: true,
    description: "What the player sees",
    showWhen(step) {
      return (
        step.animation?.is_required === "yes" &&
        step.animation?.type == "progressbar"
      );
    },
  },
  {
    type: "select",
    label: "[Progressbar] Disable Movement",
    uniqueName: "animation.progressbar.disable_movement",
    required: true,
    description: "Progressbar disable movement",
    options: [
      {
        label: "",
        value: "",
      },
      {
        label: "Yes",
        value: "yes",
      },
      {
        label: "No",
        value: "no",
      },
    ],
    showWhen(step) {
      return (
        step.animation?.is_required === "yes" &&
        step.animation?.type == "progressbar"
      );
    },
  },
  {
    type: "number",
    label: "[Animation] Duration",
    uniqueName: "animation.duration",
    required: true,
    description: "Animation duration (millisecond)",
    attributes: {
      min: 1,
      max: 10000,
    },
    showWhen(step) {
      return (
        step.animation?.is_required === "yes" &&
        step.animation?.type == "progressbar"
      );
    },
  },
  {
    type: "select",
    label: "[Animation] Is Prop Required",
    uniqueName: "animation.prop.is_required",
    required: true,
    description: "Animation is prop required ?",
    options: [
      {
        label: "",
        value: "",
      },
      {
        label: "Yes",
        value: "yes",
      },
      {
        label: "No",
        value: "no",
      },
    ],
    showWhen(step) {
      return (
        step.animation?.is_required === "yes" &&
        step.animation?.type == "progressbar"
      );
    },
  },
  {
    type: "text",
    label: "[Prop Required] Model",
    uniqueName: "animation.prop.model",
    required: true,
    description: "Prop Model",
    hintLink: "https://gtahash.ru/",
    showWhen(step) {
      return (
        step.animation?.is_required === "yes" &&
        step.animation?.prop?.is_required === "yes"
      );
    },
  },
  {
    type: "number",
    label: "[Prop Required] Bone Id",
    uniqueName: "animation.prop.bone",
    required: false,
    description: "Prop bone id",
    hintLink: "https://wiki.rage.mp/index.php?title=Bones",
    showWhen(step) {
      return (
        step.animation?.is_required === "yes" &&
        step.animation?.prop?.is_required === "yes"
      );
    },
  },
  {
    type: "coords",
    label: "[Prop Required] Coords",
    uniqueName: "animation.prop.coords",
    required: true,
    description: "Prop coords [x | y | z | heading]",
    showWhen(step) {
      return (
        step.animation?.is_required === "yes" &&
        step.animation?.prop?.is_required === "yes"
      );
    },
  },
  {
    type: "coords",
    label: "[Prop Required] Rotation",
    uniqueName: "animation.prop.rotation",
    required: true,
    description: "Prop rotation [x | y | z | heading]",
    showWhen(step) {
      return (
        step.animation?.is_required === "yes" &&
        step.animation?.prop?.is_required === "yes"
      );
    },
  },
  {
    type: "select",
    label: "Remove Item",
    uniqueName: "remove_item.is_required",
    required: true,
    description:
      "Items to be taken from the player's inventory when the step is completed",
    options: [
      { value: "", label: "" },
      {
        value: "yes",
        label: "Yes",
      },
      {
        value: "no",
        label: "No",
      },
    ],
  },
  {
    type: "text",
    label: "[Remove Item] Name",
    uniqueName: "remove_item.item_name",
    required: true,
    description: "Item name to be removed",
    showWhen: (step) => step.remove_item?.is_required === "yes",
  },
  {
    type: "number",
    label: "[Remove Item] Count",
    uniqueName: "remove_item.count",
    required: true,
    description: "Amount of items to be removed",
    showWhen: (step) => step.remove_item?.is_required === "yes",
  },
  {
    type: "select",
    label: "Give Item",
    uniqueName: "give_item.is_required",
    required: true,
    description:
      "Items that will be given to the player's inventory upon completion of the step",
    options: [
      { value: "", label: "" },
      {
        value: "yes",
        label: "Yes",
      },
      {
        value: "no",
        label: "No",
      },
    ],
  },
  {
    type: "text",
    label: "[Give Item] Name",
    uniqueName: "give_item.item_name",
    required: true,
    description: "Item name to be given",
    showWhen: (step) => step.give_item?.is_required === "yes",
  },
  {
    type: "number",
    label: "[Give Item] Count",
    uniqueName: "give_item.count",
    required: true,
    description: "Amount of items to be given",
    showWhen: (step) => step.give_item?.is_required === "yes",
  },
  {
    type: "select",
    label: "Give Money",
    uniqueName: "give_money.is_required",
    required: true,
    description:
      "When you complete the step, it gives the specified type of money.",
    options: [
      { value: "", label: "" },
      {
        value: "yes",
        label: "Yes",
      },
      {
        value: "no",
        label: "No",
      },
    ],
  },
  {
    type: "select",
    label: "[Give Money] Type",
    uniqueName: "give_money.type",
    required: true,
    description: "Money type; bank or cash",
    options: [
      { value: "", label: "" },
      { value: "bank", label: "Bank" },
      { value: "cash", label: "Cash" },
    ],
    showWhen: (step) => step.give_money?.is_required === "yes",
  },
  {
    type: "number",
    label: "[Give Money] Amount",
    uniqueName: "give_money.amount",
    required: true,
    description: "Amount",
    attributes: {
      min: 1,
      max: 10000000,
    },
    showWhen: (step) => step.give_money?.is_required === "yes",
  },
  {
    type: "text",
    label: "[Give Money] Reason",
    uniqueName: "give_money.reason",
    required: true,
    description: "Reason for why you gave the money",
    showWhen: (step) => step.give_money?.is_required === "yes",
  },
  {
    type: "select",
    label: "Remove Money",
    uniqueName: "remove_money.is_required",
    required: true,
    description:
      "When you complete the step, it gives the specified type of money.",
    options: [
      { value: "", label: "" },
      {
        value: "yes",
        label: "Yes",
      },
      {
        value: "no",
        label: "No",
      },
    ],
  },
  {
    type: "select",
    label: "[Remove Money] Type",
    uniqueName: "remove_money.type",
    required: true,
    description: "Money type; bank or cash",
    options: [
      { value: "", label: "" },
      { value: "bank", label: "Bank" },
      { value: "cash", label: "Cash" },
    ],
    showWhen: (step) => step.remove_money?.is_required === "yes",
  },
  {
    type: "number",
    label: "[Remove Money] Amount",
    uniqueName: "remove_money.amount",
    required: true,
    description: "Amount",
    attributes: {
      min: 1,
      max: 10000000,
    },
    showWhen: (step) => step.remove_money?.is_required === "yes",
  },
  {
    type: "text",
    label: "[Remove Money] Reason",
    uniqueName: "remove_money.reason",
    required: true,
    description: "Reason for why you received the money",
    showWhen: (step) => step.remove_money?.is_required === "yes",
  },
];
