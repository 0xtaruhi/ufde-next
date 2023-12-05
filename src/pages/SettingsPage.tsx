import { Combobox, useCombobox, InputBase, Input, Divider, ScrollArea } from "@mantine/core";
import { useMemo, useState } from "react";
import { useTranslation } from "react-i18next";
import ReactCountryFlag from "react-country-flag";
import i18n from "i18next";

interface Language {
  name: string;
  countryCode: string;
  code: string;
}

const languages: Language[] = [
  { name: "English", countryCode: "US", code: "en" },
  { name: "简体中文", countryCode: "CN", code: "zh" },
  { name: "日本語", countryCode: "JP", code: "ja" },
];

function getCurrentLanguage(): Language | undefined {
  const code = i18n.language;
  return languages.find((language) => language.code === code);
}

function getLanguageFromName(name: string): Language | undefined {
  return languages.find((language) => language.name === name);
}

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
      <ScrollArea>
        <Divider my="xs" label={t("settings.general")} labelPosition="left" />
        <LanguageSelector />
      </ScrollArea>
    </>
  );
}

export default SettingsPage;