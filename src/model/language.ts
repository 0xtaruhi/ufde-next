import i18n from "i18next";

export type Language = {
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

export { languages, getCurrentLanguage, getLanguageFromName };
