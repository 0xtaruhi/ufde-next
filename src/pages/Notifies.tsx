import { notifications } from "@mantine/notifications";
import { TFunction } from "i18next";
import { TbX, TbCheck } from "react-icons/tb";

export function showFailedNotification({
  translation,
  message,
  title,
}: {
  translation: TFunction<"translation", undefined>;
  message: string;
  title: string;
}) {
  notifications.show({
    icon: <TbX />,
    color: "red",
    title: translation(title),
    message: translation(message),
  });
}

export function showSuccessNotification({
  translation,
  message,
  title,
}: {
  translation: TFunction<"translation", undefined>;
  message: string;
  title: string;
}) {
  notifications.show({
    icon: <TbCheck />,
    color: "green",
    title: translation(title),
    message: translation(message),
  });
}

function showProgramFailedNotification({
  translation,
  message,
}: {
  translation: TFunction<"translation", undefined>;
  message: string;
}) {
  showFailedNotification({ translation: translation, message: message, title: "program.failed" });
}

export default showProgramFailedNotification;
