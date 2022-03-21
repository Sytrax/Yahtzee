Add-Type -AssemblyName PresentationFramework

$global:Play = $true
$global:keep1 = $false
$global:keep2 = $false
$global:keep3 = $false
$global:keep4 = $false
$global:keep5 = $false
$global:rollcount = 0
$global:dice1 
$global:dice2 
$global:dice3 
$global:dice4 
$global:dice5 
$global:pcount = 0
$global:inputcount = 0


function blackjack{

$global:Play = $false

[xml]$xaml = @"
<Window
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    Title="Yahtzee" Height="500" Width="1000">

    <Grid>
        <TextBox HorizontalAlignment="Left" Height="23" TextWrapping="Wrap" Text="Scoreboard" VerticalAlignment="Top" Width="121" Margin="492,2,0,0" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="23" Margin="492,25,0,0" TextWrapping="Wrap" Text="Ones (5)" VerticalAlignment="Top" Width="121" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="23" Margin="492,48,0,0" TextWrapping="Wrap" Text="Twos (10)" VerticalAlignment="Top" Width="121" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="23" Margin="492,71,0,0" TextWrapping="Wrap" Text="Threes (15)" VerticalAlignment="Top" Width="121" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="24" Margin="492,94,0,0" TextWrapping="Wrap" Text="Fours (20)" VerticalAlignment="Top" Width="121" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="22" Margin="492,118,0,0" TextWrapping="Wrap" Text="Fives (25)" VerticalAlignment="Top" Width="121" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="23" TextWrapping="Wrap" Text="Sixes (30)" VerticalAlignment="Top" Width="121" Margin="492,138,0,0" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="23" Margin="492,161,0,0" TextWrapping="Wrap" Text="Sum (63-105)" VerticalAlignment="Top" Width="121" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="23" Margin="492,184,0,0" TextWrapping="Wrap" Text="Bonus (50)" VerticalAlignment="Top" Width="121" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="23" Margin="492,207,0,0" TextWrapping="Wrap" Text="One pair (12)" VerticalAlignment="Top" Width="121" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="23" Margin="492,230,0,0" TextWrapping="Wrap" Text="Two pairs (22)" VerticalAlignment="Top" Width="121" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="22" Margin="492,253,0,0" TextWrapping="Wrap" Text="3 of a kind(18)" VerticalAlignment="Top" Width="121" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="23" TextWrapping="Wrap" Text="4 of a kind(24)" VerticalAlignment="Top" Width="121" Margin="492,275,0,0" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="24" Margin="492,298,0,0" TextWrapping="Wrap" Text="Full house(28)" VerticalAlignment="Top" Width="121" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="23" Margin="492,322,0,0" TextWrapping="Wrap" Text="Sm. Straight(15)" VerticalAlignment="Top" Width="121" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="23" Margin="492,345,0,0" TextWrapping="Wrap" Text="Lg. Straight(20)" VerticalAlignment="Top" Width="121" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="23" Margin="492,368,0,0" TextWrapping="Wrap" Text="Yahtzee(50)" VerticalAlignment="Top" Width="121" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="22" Margin="492,391,0,0" TextWrapping="Wrap" Text="Chance(30)" VerticalAlignment="Top" Width="121" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="23" Margin="492,413,0,0" TextWrapping="Wrap" Text="Total" VerticalAlignment="Top" Width="121" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="25" Margin="492,436,0,0" TextWrapping="Wrap" Text="Grand total" VerticalAlignment="Top" Width="121" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="25" Margin="611,2,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="62" Name="p1name" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="25" Margin="611,25,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="62" Name="p1ones" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="25" Margin="611,48,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="62" Name="p1twos" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="25" Margin="611,71,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="62" Name="p1threes" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="26" Margin="611,94,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="62" Name="p1fours" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="24" Margin="611,118,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="62" Name="p1fives" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="25" Margin="611,138,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="62" Name="p1sixes" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="25" Margin="611,161,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="62" Name="p1sum" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="25" Margin="611,184,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="62" Name="p1bonus" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="25" Margin="611,207,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="62" Name="p1onepair" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="25" Margin="611,230,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="62" Name="p1twopair" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="24" Margin="611,253,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="62" Name="p13ofakind" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="25" Margin="611,275,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="62" Name="p14ofakind" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="26" Margin="611,298,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="62" Name="p1fullhouse" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="25" Margin="611,322,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="62" Name="p1smstraight" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="25" Margin="611,345,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="62" Name="p1lgstraight" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="25" Margin="611,368,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="62" Name="p1yahtzee" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="24" Margin="611,391,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="62" Name="p1Chance" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="25" Margin="611,413,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="62" Name="p1total" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="25" Margin="611,436,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="62" Name="p1grandtotal" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="25" Margin="673,2,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="63" Name="p2name" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="25" Margin="673,25,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="63" Name="p2ones" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="25" Margin="673,48,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="63"  Name="p2twos" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="25" Margin="673,71,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="63" Name="p2threes" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="26" Margin="673,94,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="63" Name="p2fours" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="24" Margin="673,118,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="63" Name="p2fives" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="25" Margin="673,138,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="63" Name="p2sixes" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="25" Margin="673,161,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="63" Name="p2sum" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="25" Margin="673,184,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="63" Name="p2bonus" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="25" Margin="673,207,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="63" Name="p2onepair" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="25" Margin="673,230,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="63" Name="p2twopair" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="24" Margin="673,253,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="63" Name="p23ofakind" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="25" Margin="673,275,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="63" Name="p24ofakind" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="26" Margin="673,298,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="63" Name="p2fullhouse" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="25" Margin="673,322,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="63" Name="p2smstraight" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="25" Margin="673,345,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="63" Name="p2lgstraight" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="25" Margin="673,368,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="63" Name="p2yahtzee" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="24" Margin="673,391,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="63" Name="p2chance" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="25" Margin="673,413,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="63" Name="p2total" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="25" Margin="673,436,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="63" Name="p2grandtotal" IsReadOnly="True"/>
        <TextBox HorizontalAlignment="Left" Height="25" Margin="736,25,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="736,48,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="736,71,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="26" Margin="736,94,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="24" Margin="736,118,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="736,138,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="736,161,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="736,184,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="736,207,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="736,230,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="24" Margin="736,253,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="736,275,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="26" Margin="736,298,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="736,322,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="736,345,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="736,368,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="24" Margin="736,391,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="736,413,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="736,2,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="736,436,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="798,25,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="63" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="798,48,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="63" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="798,71,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="63" />
        <TextBox HorizontalAlignment="Left" Height="26" Margin="798,94,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="63" />
        <TextBox HorizontalAlignment="Left" Height="24" Margin="798,118,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="63" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="798,138,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="63" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="798,161,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="63" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="798,184,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="63" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="798,207,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="63" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="798,230,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="63" />
        <TextBox HorizontalAlignment="Left" Height="24" Margin="798,253,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="63" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="798,275,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="63" />
        <TextBox HorizontalAlignment="Left" Height="26" Margin="798,298,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="63" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="798,322,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="63" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="798,345,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="63" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="798,368,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="63" />
        <TextBox HorizontalAlignment="Left" Height="24" Margin="798,391,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="63" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="798,413,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="63" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="798,2,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="63" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="798,436,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="63" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="861,25,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="861,48,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="861,71,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="26" Margin="861,94,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="24" Margin="861,118,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="861,138,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="861,161,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="861,184,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="861,207,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="861,230,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="24" Margin="861,253,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="861,275,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="26" Margin="861,298,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="861,322,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="861,345,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="861,368,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="24" Margin="861,391,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="861,413,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="861,2,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="861,436,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="923,25,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="923,48,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="923,71,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="26" Margin="923,94,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="24" Margin="923,118,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="923,138,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="923,161,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="923,184,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="923,207,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="923,230,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="24" Margin="923,253,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="923,275,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="26" Margin="923,298,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="923,322,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="923,345,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="923,368,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="24" Margin="923,391,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="923,413,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="923,2,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />
        <TextBox HorizontalAlignment="Left" Height="25" Margin="923,436,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="62" />

    <Image Name ="dice1" HorizontalAlignment="Left" Height="50" VerticalAlignment="Top" Width="0" Margin="20,20,0,0" Source="https://upload.wikimedia.org/wikipedia/commons/c/c5/Dice-1.png"/>
    <Image Name ="dice2" HorizontalAlignment="Left" Height="50" VerticalAlignment="Top" Width="0" Margin="70,20,0,0" Source="https://upload.wikimedia.org/wikipedia/commons/1/18/Dice-2.png"/>
    <Image Name ="dice3" HorizontalAlignment="Left" Height="50" VerticalAlignment="Top" Width="0" Margin="120,20,0,0" Source="https://upload.wikimedia.org/wikipedia/commons/7/70/Dice-3.png"/>
    <Image Name ="dice4" HorizontalAlignment="Left" Height="50" VerticalAlignment="Top" Width="0" Margin="170,20,0,0" Source="https://upload.wikimedia.org/wikipedia/commons/a/a9/Dice-4.png"/>
    <Image Name ="dice5" HorizontalAlignment="Left" Height="50" VerticalAlignment="Top" Width="0" Margin="220,20,0,0" Source="https://upload.wikimedia.org/wikipedia/commons/6/6c/Dice-5.png"/>
    <Image Name ="dice6" HorizontalAlignment="Left" Height="50" VerticalAlignment="Top" Width="0" Margin="270,20,0,0" Source="https://upload.wikimedia.org/wikipedia/commons/5/5c/Dice-6.png"/>
    <Image Name ="roll1" HorizontalAlignment="Left" Height="50" VerticalAlignment="Top" Width="50" Margin="20,20,0,0" Source=""/>
    <Image Name ="roll2" HorizontalAlignment="Left" Height="50" VerticalAlignment="Top" Width="50" Margin="112,20,0,0" Source=""/>
    <Image Name ="roll3" HorizontalAlignment="Left" Height="50" VerticalAlignment="Top" Width="50" Margin="204,20,0,0" Source=""/>
    <Image Name ="roll4" HorizontalAlignment="Left" Height="50" VerticalAlignment="Top" Width="50" Margin="296,20,0,0" Source=""/>
    <Image Name ="roll5" HorizontalAlignment="Left" Height="50" VerticalAlignment="Top" Width="50" Margin="388,20,0,0" Source=""/>
    <Button Name ="btnPlay" Content="Roll" HorizontalAlignment="Left" Margin="210,289,0,0" VerticalAlignment="Top" Width="75"/>
    <Button Name ="btnkeep1" Content="Keep" HorizontalAlignment="Left" Margin="20,90,0,0" VerticalAlignment="Top" Width="50" Background="White"/>
    <Button Name ="btnkeep2" Content="Keep" HorizontalAlignment="Left" Margin="112,90,0,0" VerticalAlignment="Top" Width="50" Background="White"/>
    <Button Name ="btnkeep3" Content="Keep" HorizontalAlignment="Left" Margin="204,90,0,0" VerticalAlignment="Top" Width="50" Background="White"/>
    <Button Name ="btnkeep4" Content="Keep" HorizontalAlignment="Left" Margin="296,90,0,0" VerticalAlignment="Top" Width="50" Background="White"/>
    <Button Name ="btnkeep5" Content="Keep" HorizontalAlignment="Left" Margin="388,90,0,0" VerticalAlignment="Top" Width="50" Background="White"/>
    <TextBox Name ="txtInput" HorizontalAlignment="Left" Height="20" TextWrapping="Wrap" VerticalAlignment="Top" Width="150" Margin="10,314,0,0" Text=""/>
    <TextBox Name ="txtPlayerCount" HorizontalAlignment="Left" Height="20" TextWrapping="Wrap" VerticalAlignment="Top" Width="150" Margin="10,293,0,0" Text="How many players?(1-6)" IsReadOnly="True"/>
    <Button Name ="btnInput" Content="Input" HorizontalAlignment="Left" Margin="10,335,0,0" VerticalAlignment="Top" Width="150" Height ="20"/>
    <TextBox Name ="txtDice" HorizontalAlignment="Left" Height="50" TextWrapping="Wrap" VerticalAlignment="Top" Width="75" Margin="210,314,0,0" Text="" IsReadOnly="True"/>
    </Grid>
</Window>
"@

$reader = (New-Object System.Xml.XmlNodeReader $xaml)
try {
    $window = [Windows.Markup.XamlReader]::Load( $reader )
}
catch {
    Write-Warning $_.Exception
    throw
}


#Create variables based on form control names.
#Variable will be named as 'var_<control name>'

$xaml.SelectNodes("//*[@Name]") | ForEach-Object {
    #"trying item $($_.Name)";
    try {
        Set-Variable -Name "var_$($_.Name)" -Value $window.FindName($_.Name) -ErrorAction Stop
    } catch {
        throw
   }
}



   

Get-Variable var_*


    dicekeep 

    $var_btnInput.Add_Click({
    
    if($global:inputcount -eq $global:pcount -and $global:pcount -gt 0){
    $var_txtPlayerCount.Width = "0"
    $var_txtInput.Width = "0"
    $var_btnInput.Width = "0"}

    try{
    if($global:inputcount -eq 0 -and [int]$var_txtInput.Text -is [int])
    {$global:pcount = [int]$var_txtInput.Text
    $var_txtInput.Text = ""
    }}
    catch { $var_txtPlayerCount.Text = "Invalid input, try agian"}
    
    if($global:pcount -gt 0 -and $global:inputcount -eq 0){$var_txtPlayerCount.Text = "Name of player one?"}
    if($global:pcount -gt 0 ){
    switch($global:inputcount){
    1 {$var_p1name.Text = $var_txtInput.Text
    if($global:pcount -gt 0 -and $global:inputcount -lt $global:pcount){$var_txtPlayerCount.Text = "Name of player two?"}else{$var_txtPlayerCount.Text = ""}
    $var_txtInput.Text = ""}
    2{$var_p2name.Text = $var_txtInput.Text
    if($global:pcount -gt 0 -and $global:inputcount -lt $global:pcount){$var_txtPlayerCount.Text = "Name of player three?"}else{$var_txtPlayerCount.Text = ""}
    $var_txtInput.Text = ""}
    }
    $global:inputcount = $global:inputcount + 1
    }


    })
    

    $var_btnPlay.Add_Click({
    
    diceroll

    })



    $Null = $window.ShowDialog()
    start-sleep -Seconds 2
}



function dicekeep(){

$var_btnkeep1.Add_Click({

if($var_roll1.Source -and $global:rollcount -lt 3){

switch($global:keep1){
    $true{$global:keep1 = $false
     $var_btnkeep1.Background = "White"}
    $false{ $global:keep1 = $true
     $var_btnkeep1.Background = "#FF5BA630"}
    }
    }

})

$var_btnkeep2.Add_Click({

if($var_roll2.Source -and $global:rollcount -lt 3){

switch($global:keep2){
    $true{$global:keep2 = $false
     $var_btnkeep2.Background = "White"}
    $false{ $global:keep2 = $true
     $var_btnkeep2.Background = "#FF5BA630"}
}
}
})
$var_btnkeep3.Add_Click({

if($var_roll3.Source -and $global:rollcount -lt 3){

switch($global:keep3){
    $true{$global:keep3 = $false
     $var_btnkeep3.Background = "White"}
    $false{ $global:keep3 = $true
     $var_btnkeep3.Background = "#FF5BA630"}
}
}

})
$var_btnkeep4.Add_Click({

if($var_roll4.Source -and $global:rollcount -lt 3){

switch($global:keep4){
    $true{$global:keep4 = $false
     $var_btnkeep4.Background = "White"}
    $false{ $global:keep4 = $true
     $var_btnkeep4.Background = "#FF5BA630"}

     }
     }
})
$var_btnkeep5.Add_Click({

if($var_roll5.Source -and $global:rollcount -lt 3){

switch($global:keep5){
    $true{$global:keep5 = $false
     $var_btnkeep5.Background = "White"}
    $false{ $global:keep5 = $true
     $var_btnkeep5.Background = "#FF5BA630"}

}
}
})
}







function diceroll(){

$array1 = @($var_roll1, $global:keep1, '$global:dice1')
$array2 = @($var_roll2, $global:keep2, '$global:dice2')
$array3 = @($var_roll3, $global:keep3, '$global:dice3')
$array4 = @($var_roll4, $global:keep4, '$global:dice4')
$array5 = @($var_roll5, $global:keep5, '$global:dice5')

$rolls = @($array1, $array2, $array3, $array4, $array5)

if($global:rollcount -lt 3){


foreach($roll in $rolls){

$number = get-random -maximum 7 -minimum 1

if($roll[1]){$roll[0].Source = $roll[0].Source}
else{

switch($roll[2]){
    '$global:dice1' {$global:dice1 = $number}
    '$global:dice2' {$global:dice2 = $number}
    '$global:dice3' {$global:dice3 = $number}
    '$global:dice4' {$global:dice4 = $number}
    '$global:dice5' {$global:dice5 = $number}
    }

switch($number){
  
    1 {$roll[0].Source = $var_dice1.Source}
    2 {$roll[0].Source = $var_dice2.Source}
    3 {$roll[0].Source = $var_dice3.Source}
    4 {$roll[0].Source = $var_dice4.Source}
    5 {$roll[0].Source = $var_dice5.Source}
    6 {$roll[0].Source = $var_dice6.Source}

}
}
}

$global:rollcount = $global:rollcount + 1

$var_txtDice.Text = "$global:dice1 $global:dice2 $global:dice3 $global:dice4 $global:dice5" 

if($global:rollcount -eq 3){
 $var_btnkeep1.Background = "#FF5BA630"
  $var_btnkeep2.Background = "#FF5BA630"
   $var_btnkeep3.Background = "#FF5BA630"
    $var_btnkeep4.Background = "#FF5BA630"
     $var_btnkeep5.Background = "#FF5BA630"}



} 

}

    while($global:Play)
{
    blackjack
}
