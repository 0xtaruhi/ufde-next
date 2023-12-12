import { Combobox, useCombobox, InputBase, Input, Divider, ScrollArea, Card } from "@mantine/core";

import { useMemo, useState } from "react";
import { useTranslation } from "react-i18next";
import ReactCountryFlag from "react-country-flag";
import i18n from "i18next";

import { getCurrentLanguage, getLanguageFromName, languages } from "../model/language";

function LanguageSelector() {
  const comboBox = useCombobox({
    onDropdownClose: () => comboBox.resetSelectedOption(),
  });

  const initLanugage = useMemo(() => getCurrentLanguage(), []);

  const [value, setValue] = useState(initLanugage?.name);
  const { t } = useTranslation();

  const changeLanguage = (languageName: string) => {
    const language = getLanguageFromName(languageName);
    if (language) {
      i18n.changeLanguage(language.code);
      setValue(languageName);
    }
  };

  const options = languages.map((language) => (
    <Combobox.Option value={language.name} key={language.name}>
      <ReactCountryFlag countryCode={language.countryCode} /> {language.name}
    </Combobox.Option>
  ));

  return (
    <>
      <Combobox
        store={comboBox}
        onOptionSubmit={(val) => {
          setValue(val);
          changeLanguage(val);
          comboBox.closeDropdown();
        }}
      >
        <Combobox.Target>
          <InputBase
            component="button"
            label={t("settings.language")}
            pointer
            rightSection={<Combobox.Chevron />}
            onClick={() => comboBox.toggleDropdown()}
          >
            {value || <Input.Placeholder>Pick value</Input.Placeholder>}
          </InputBase>
        </Combobox.Target>

        <Combobox.Dropdown>
          <Combobox.Options>{options}</Combobox.Options>
        </Combobox.Dropdown>
      </Combobox>

    </>
  );
}

function SettingsPage() {
  const { t } = useTranslation();

  return (
    <>
      <Divider my="xs" label={t("settings.general")} labelPosition="center" />
      <Card radius={10} p="lg" shadow="sm">
        <ScrollArea>
          <LanguageSelector />
        </ScrollArea>
      </Card>
    </>
  );
}

export default SettingsPage;
