import { notifications } from "@mantine/notifications";
import { TbX, TbCheck, TbExclamationMark } from "react-icons/tb";

export function showFailedNotification({
  message,
  title,
}: {
  message: string;
  title: string;
}) {
  notifications.show({
    icon: <TbX />,
    color: "red",
    title: title,
    message: message,
  });
}

export function showWarningNotification({ message, title }: { message: string; title: string }) {
  notifications.show({
    icon: <TbExclamationMark />,
    color: "yellow.5",
    title: title,
    message: message,
  });
}

export function showSuccessNotification({
  message,
  title,
}: {
  message: string;
  title: string;
}) {
  notifications.show({
    icon: <TbCheck />,
    color: "green",
    title: title,
    message: message,
  });
}
