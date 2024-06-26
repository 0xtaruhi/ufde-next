import { notifications } from "@mantine/notifications";
import { TbX, TbCheck, TbExclamationMark } from "react-icons/tb";

export function showFailedNotification({ message, title }: { message: string; title: string }) {
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

export function showSuccessNotification({ message, title }: { message: string; title: string }) {
  notifications.show({
    icon: <TbCheck />,
    color: "green",
    title: title,
    message: message,
    autoClose: 3000,
  });
}

export function update2SuccessNotification({ id, message, title }: { id: string; message: string; title: string }) {
  notifications.update({
    id: id,
    icon: <TbCheck />,
    color: "green",
    title: title,
    message: message,
    loading: false,
    autoClose: 3000,
  });
}

export function update2FailedNotification({ id, message, title }: { id: string; message: string; title: string }) {
  notifications.update({
    id: id,
    icon: <TbX />,
    color: "red",
    title: title,
    message: message,
    loading: false,
  });
}