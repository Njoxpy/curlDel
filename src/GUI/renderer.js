const { PDFDocument } = require('pdf-lib');

// Function to send a request with appropriate method and data
function sendRequest(method) {
    // Get values from the input fields
    const endpoint = document.getElementById('endpoint').value;
    const jsonData = document.getElementById('json').value;
    const token = document.getElementById('token').value;  // Get the Bearer Token

    // Set up the request headers
    let headers = {
        'Content-Type': 'application/json',
        'Authorization': token ? `Bearer ${token}` : '',  // Include Bearer Token if provided
    };

    // Set up the request options
    let options = {
        method: method,
        headers: headers
    };

    // Add body to POST/PUT methods
    if (method === 'POST' || method === 'PUT') {
        try {
            // Parse and stringifying JSON data from the user input
            options.body = JSON.stringify(JSON.parse(jsonData));
        } catch (error) {
            // If invalid JSON is entered, show an error
            document.getElementById('response').textContent = "Error: Invalid JSON data!";
            return;
        }
    }

    // Show loading message while waiting for the response
    document.getElementById('response').textContent = 'Loading...';

    // Send the request using Fetch API
    fetch(endpoint, options)
        .then(response => {
            if (!response.ok) {
                // Handle non-200 responses (e.g., 400, 401, 500)
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            return response.json();  // Parse the response as JSON
        })
        .then(data => {
            // Display the formatted JSON response
            document.getElementById('response').textContent = JSON.stringify(data, null, 2);

            // Trigger PDF generation after receiving the response
            generatePDF(data);
        })
        .catch(error => {
            // Handle errors and display the error message
            document.getElementById('response').textContent = `Error: ${error.message}`;
        });
}

// Function to generate PDF from the API response
async function generatePDF(data) {
    const pdfDoc = await PDFDocument.create();
    const page = pdfDoc.addPage([600, 800]); // Set page size
    const font = await pdfDoc.embedFont(PDFDocument.Font.Helvetica);
    const { width, height } = page.getSize();
    const fontSize = 12;

    let yPosition = height - 50;  // Starting position on the Y-axis

    // Set up the title for the PDF
    page.drawText('API Response PDF', { x: 50, y: yPosition, size: fontSize, font });

    // Adjust the Y position for the rest of the content
    yPosition -= 40;

    // Convert the data object to a string and add it to the PDF
    const jsonString = JSON.stringify(data, null, 2);
    page.drawText(jsonString, { x: 50, y: yPosition, size: fontSize, font });

    // Serialize the document to bytes and create a download link
    const pdfBytes = await pdfDoc.save();

    // Create a Blob from the generated PDF
    const blob = new Blob([pdfBytes], { type: 'application/pdf' });

    // Create a download link for the PDF
    const link = document.createElement('a');
    link.href = URL.createObjectURL(blob);
    link.download = 'response.pdf';
    link.click();  // Automatically trigger the download
}

// Attach event listeners to buttons for sending the requests
document.querySelector('button[onclick="sendRequest(\'GET\')"]').addEventListener('click', () => sendRequest('GET'));
document.querySelector('button[onclick="sendRequest(\'POST\')"]').addEventListener('click', () => sendRequest('POST'));
document.querySelector('button[onclick="sendRequest(\'PUT\')"]').addEventListener('click', () => sendRequest('PUT'));
document.querySelector('button[onclick="sendRequest(\'DELETE\')"]').addEventListener('click', () => sendRequest('DELETE'));
