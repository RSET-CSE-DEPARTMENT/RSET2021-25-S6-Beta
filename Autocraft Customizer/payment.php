<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment</title>
    <link rel="stylesheet" href="paystyles.css">
</head>
<body>
    
<div class="container">
    <h2>Payment</h2>
    <form action="process_payment.php" method="post">
        <label for="card_number">Card Number:</label>
        <input type="text" id="card_number" name="card_number" placeholder="Enter your card number" required>
        
        <label for="expiry_date">Expiry Date:</label>
        <input type="text" id="expiry_date" name="expiry_date" placeholder="MM/YY" required>
        
        <label for="cvv">CVV:</label>
        <input type="text" id="cvv" name="cvv" placeholder="Enter CVV" required>

        <label for="amount"><?php $file = 'data1.txt';
$cost = file_get_contents($file);
echo "Total amount = ₹";
echo $cost;
echo "/-"; ?></label>

        <input type="submit" value="Pay Now">
    </form>
</div>

</body>
</html>