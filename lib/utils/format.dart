String capital(String text) => text != null && text.length > 1
    ? text.substring(0, 1).toUpperCase() + text.substring(1)
    : "";
