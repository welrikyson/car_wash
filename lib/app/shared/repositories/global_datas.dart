

//TODO: how to work with Environment Variables
const flagDebug = false;

const UrlBaseServe = flagDebug ? UrlBaseServeDebug :  UrlBaseServeProduction;
const UrlBaseServeDebug = "http://192.168.0.63/lavafacil";
const UrlBaseServeProduction = "http://ciadopescado.com.br/gap";