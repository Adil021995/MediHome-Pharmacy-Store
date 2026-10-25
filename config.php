<?php
declare(strict_types=1);
if (session_status() === PHP_SESSION_NONE) session_start();
$host='127.0.0.1'; $port='3307'; // Change to 3307 if your XAMPP MySQL uses that port.
$db='medihome'; $user='root'; $pass='';
try {
 $pdo=new PDO("mysql:host=$host;port=$port;dbname=$db;charset=utf8mb4",$user,$pass,[
  PDO::ATTR_ERRMODE=>PDO::ERRMODE_EXCEPTION,
  PDO::ATTR_DEFAULT_FETCH_MODE=>PDO::FETCH_ASSOC,
  PDO::ATTR_EMULATE_PREPARES=>false
 ]);
} catch(PDOException $e) { http_response_code(500); exit('Database connection failed. Check config.php and import database/medihome.sql.'); }
function e($v): string { return htmlspecialchars((string)($v??''),ENT_QUOTES,'UTF-8'); }
function money($v): string { return '₹'.number_format((float)$v,2); }
function logged_in(): bool { return isset($_SESSION['user_id']); }
function admin_in(): bool { return isset($_SESSION['admin_id']); }
function count_cart(): int { return array_sum(array_map('intval',$_SESSION['cart']??[])); }
function flash($m,$type='success'): void { $_SESSION['flash']=['m'=>$m,'t'=>$type]; }
function show_flash(): void { if(isset($_SESSION['flash'])) { $f=$_SESSION['flash']; echo '<div class="flash '.e($f['t']).'">'.e($f['m']).'</div>'; unset($_SESSION['flash']); } }
function go($url): never { header('Location: '.$url); exit; }
function require_user(): void { if(!logged_in()){flash('Please log in to continue.','error');go('/MediHome/login.php');} }
function require_admin(): void { if(!admin_in()) go('/MediHome/admin/login.php'); }
