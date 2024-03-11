import { Modal, ModalProps } from "@mantine/core"
import { SourceFile } from "../model/project"

interface GenConstraintModalProps extends ModalProps {
    file: SourceFile;
};

export default function GenConstraintModal(props: GenConstraintModalProps) {
    return <>
        <Modal {...props}>
            
        </Modal>
    </>
}
