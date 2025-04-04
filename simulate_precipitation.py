import random
import time
from firebase_admin import credentials, initialize_app, db
import math

# Initialisation de Firebase
cred = credentials.Certificate("serviceAccountKey.json")
firebase_app = initialize_app(cred, {
    'databaseURL': 'https://weatherinsti-default-rtdb.firebaseio.com/'
})

# Obtenir une référence à la base de données
ref = db.reference('weather_data')

def generate_precipitation():
    """Génère une valeur de précipitation réaliste"""
    base_value = random.gauss(15, 10)  # moyenne de 15mm, écart-type de 10mm
    return max(0, base_value)

def generate_temperature():
    """Génère une valeur de température réaliste (en °C)"""
    base_value = random.gauss(25, 5)  # moyenne de 25°C, écart-type de 5°C
    return round(base_value, 1)

def generate_humidity():
    """Génère une valeur d'humidité réaliste (en %)"""
    base_value = random.gauss(60, 15)  # moyenne de 60%, écart-type de 15%
    return min(100, max(0, round(base_value, 1)))  # Limite entre 0 et 100%

def generate_pressure():
    """Génère une valeur de pression atmosphérique réaliste (en hPa)"""
    base_value = random.gauss(1013.25, 5)  # moyenne de 1013.25 hPa, écart-type de 5 hPa
    return round(base_value, 2)

def generate_aqi():
    """Génère une valeur d'indice de qualité de l'air réaliste"""
    base_value = random.gauss(50, 20)  # moyenne de 50, écart-type de 20
    return max(0, round(base_value))  # AQI ne peut pas être négatif

def simulate_weather_data():
    """Simule et envoie toutes les données météorologiques à Firebase"""
    try:
        while True:
            # Génération des nouvelles valeurs
            weather_data = {
                'precipitation': round(generate_precipitation(), 2),
                'temperature': generate_temperature(),
                'humidity': generate_humidity(),
                'pressure': generate_pressure(),
                'aqi': generate_aqi(),
                'timestamp': time.time()
            }
            
            try:
                # Mise à jour de toutes les données
                ref.update(weather_data)
                print("\nDonnées météorologiques mises à jour dans Firebase :")
                print(f"Précipitation : {weather_data['precipitation']} mm")
                print(f"Température : {weather_data['temperature']} °C")
                print(f"Humidité : {weather_data['humidity']} %")
                print(f"Pression : {weather_data['pressure']} hPa")
                print(f"AQI : {weather_data['aqi']}")
                print("-" * 50)
            except Exception as firebase_error:
                print(f"Erreur lors de la mise à jour Firebase : {str(firebase_error)}")
            
            # Attendre 5 secondes avant la prochaine mise à jour
            time.sleep(5)
            
    except KeyboardInterrupt:
        print("\nSimulation arrêtée par l'utilisateur")
    except Exception as e:
        print(f"Erreur : {str(e)}")

if __name__ == "__main__":
    print("Démarrage de la simulation des données météorologiques...")
    print("Connexion à Firebase établie")
    simulate_weather_data() 