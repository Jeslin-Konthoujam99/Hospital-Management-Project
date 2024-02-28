
function generatePdf() {

	console.log("Button clicked!");

	if (typeof html2pdf !== 'undefined') {
		
		const options = {
			margin: 10,
			filename: 'income_expenditure_report.pdf',
			image: { type: 'jpeg', quality: 0.98 },
			html2canvas: { scale: 2 },
			jsPDF: { unit: 'mm', format: 'a4', orientation: 'portrait' }
		};

		
		const element = document.getElementById('genPDF');

		
		html2pdf(element, options)
			.then(function(pdf) {
				console.log('PDF generated successfully:', pdf);
			})
			.catch(function(error) {
				console.error('Error generating PDF:', error);
			});
	} else {
		console.error("html2pdf is not defined. Make sure it is properly loaded.");
	}

}
