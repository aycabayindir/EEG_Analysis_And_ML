import matplotlib.pyplot as plt
from sklearn.neighbors import KNeighborsClassifier
from sklearn.neighbors import RadiusNeighborsClassifier
from sklearn.model_selection import train_test_split
from sklearn import metrics
from sklearn.preprocessing import MinMaxScaler
from sklearn.preprocessing import Normalizer
import pandas as pd
import warnings
import time
warnings.filterwarnings("ignore")
start = time.time()
a = 0
for i in range(1000):
    a += (i**100)


data = pd.read_excel('Fc5_new_simplified.xlsx')

X = data.iloc[:,0:10000]
y = data.iloc[:,-1]

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42, stratify=y)


norm = Normalizer()
norm.fit(X_train)
X_train_norm = norm.transform(X_train)
X_test_norm = norm.transform(X_test)


knn = KNeighborsClassifier(n_neighbors=25, weights='distance', metric = 'minkowski')

knn.fit(X_train_norm, y_train)

y_predict = knn.predict(X_test_norm)


print("Genauigkeitswert %.3f" %metrics.accuracy_score(y_test, y_predict))
print(f"Vorhergesagte Klass-Labels: {y_predict}")

end = time.time()
duration = (end-start) * 10**3

runtime = f"Die Laufzeit dauerte {duration:.3f} ms"
print(runtime.format(duration = (end-start) * 10**3))
