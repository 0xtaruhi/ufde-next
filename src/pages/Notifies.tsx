import { notifications } from "@mantine/notifications";
import { TFunction } from "i18next";
import { TbX } from "react-icons/tb";

function showProgramFailedNotification({
  translation,
  message,
}: {
  translation: TFunction<"translation", undefined>;
  message: string;
}) {

  notifications.show({
    icon: <TbX />,
    color: "red",
    title: translation("program.failed"),
    message: translation(message),
  });
}

export default showProgramFailedNotification;
