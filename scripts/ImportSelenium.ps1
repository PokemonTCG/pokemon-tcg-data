# PowerShell script to fetch raw contents of a webpage using Selenium

# Variables for file paths
$seleniumPath = "C:\Users\Gunna\Downloads\selenium-java-4.23.0"
$javaPath = "C:\Program Files\Java\jre-1.8\bin\java.exe"
$chromeDriverPath = "C:\Program Files\WindowsPowerShell\Modules\Selenium\3.0.1\assemblies\linux\chromedriver"

# Java classpath setup for Selenium
$classpath = "$seleniumPath\client-combined-4.23.0.jar;$seleniumPath\client-combined-4.23.0-nodeps.jar;$seleniumPath\libs\*"

# Java code to perform the web scraping
$javaCode = @"
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import java.nio.file.*;
import java.io.*;

public class WebScraper {
    public static void main(String[] args) {
        System.setProperty("webdriver.chrome.driver", "$chromeDriverPath");
        WebDriver driver = new ChromeDriver();
        driver.get("https://pokemoncard.io/deck/muddy-waters-sglc-semi-gym-leader-challenge-35660");
        
        // Get the page source (raw HTML content)
        String pageSource = driver.getPageSource();
        
        // Save the page source to a file
        try {
            Files.write(Paths.get("pageSource.html"), pageSource.getBytes());
        } catch (IOException e) {
            e.printStackTrace();
        }
        
        driver.quit();
    }
}
"@

# Save the Java code to a file
$javaFilePath = "C:\Users\Gunna\Downloads\WebScraper.java"
Set-Content -Path $javaFilePath -Value $javaCode

# Compile the Java code
& $javaPath\javac.exe -cp $classpath $javaFilePath

# Run the compiled Java program
& $javaPath\java.exe -cp "$classpath;C:\Users\Gunna\Downloads" WebScraper
