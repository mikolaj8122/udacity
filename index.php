<?php

$email = $_POST['email'] ?? null;

$status = null;
if ($email) {
  $file = fopen('emails', 'a');
  $result = fwrite($file, $email. "\n");
  fclose($file);

  if ($result !== false) {
    $status = true;
  } else {
    $status = false;
  }
}
?>

<html>

<head>
  <style>
    input {
    display: inline-block;
    }
    .error {
      color: red;
      padding: 4px 10px;
    }
  </style>
</head>
<body>
  <h1>Witam na mojej stronie</h1>
  <h3>Zapisz się na newsletter zostawiając swój adres email</h3>
  <?php if ($status === true): ?>
    <div class="message">Bravo!!! Twój email został dodany, czekaj na nowe wiadomości od nas</
    div>
  <?php elseif ($status === false) : ?>
    <div class="error">Wystąpił błąd podczas zapisu danych</div>
  <?php endif; ?>
  <section>
    <form action="/" method="POST">
      <label>Email: <input type="email" name="email" /></label>
      <input type="submit" value="Zapisz na newsletter" />
    </form>
  </section>
</body>

</html>
