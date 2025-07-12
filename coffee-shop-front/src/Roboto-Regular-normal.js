import { jsPDF } from "jspdf"
var font = 'Roboto-Regular';
var callAddFont = function () {
this.addFileToVFS('Roboto-Regular.ttf', font);
this.addFont('Roboto-Regular.ttf', 'Roboto-Regular', 'normal');
};
jsPDF.API.events.push(['addFonts', callAddFont])
