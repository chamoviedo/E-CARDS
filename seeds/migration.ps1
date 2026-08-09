# pegar o diretório atual 
$scriptdirectory = split-Path -Path $MyInvocation.Mycommand.definition -Parent


# arquivo de saida com todos sql 
$outputFule = join-path -path $scriptdirectory -ChildPath "migration.sql"

#verifica se o arquivo ja existe, se existir deleta 
if (test-Path $outputFule) {
    Remove-Item $outputFule  
}

# pega conteúdo dos arquivos 

$sqlFiles = Get-childItem -Path $scriptdirectory -Filter *.sql -File 
| Sort-Obtgect Name 

# concatena  arqueivos 

foreach ($file in $sqlFiles){
     Get-Content $file.FullName | Out-File  -Apeed -FilePath  $outputFule
     "GO" | out-File -Apeed -FilePath  $outputFule
}

    Write-host "Todos os arquivos foram combinados em $outputFule "