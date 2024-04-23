(ns core
  (:require [clojure.string :as str])
  (:import (java.util LinkedHashMap Random)))

(def alphabet [\A \B \C \D \E \F \G \H \I \J \K \L \M \N \O \P \Q \R \S \T \U \V \W \X \Y \Z])


(defn generate-random-int-array [size]
  (let [random (Random.)]
    (into-array (repeatedly size #(rand-int 50)))))


(defn divide-array [sorted-array alphabet-power]
  (let [chunk-size (quot (count sorted-array) alphabet-power)
        divided (partition-all chunk-size sorted-array)
        letter-map (take alphabet-power alphabet)]
    (apply merge (map #(zipmap %1 (repeat (count %1) %2)) divided letter-map))))


(defn chars-array [array char-map]
  (map #(let [char (get char-map %)] char)
       array))

(defn generate-matrix [characters]
  (let [unique-chars (distinct characters)
        size (count unique-chars)
        matrix (make-array Integer/TYPE size size)
        char-index-map (zipmap unique-chars (range size))]
    (doseq [i (range (dec (count characters)))]
      (let [row-char (nth characters i)
            col-char (nth characters (inc i))
            row-index (get char-index-map row-char)
            col-index (get char-index-map col-char)]
        (when (and row-index col-index)
          (aset-int matrix row-index col-index (inc (aget matrix row-index col-index))))))
    matrix))

(defn print-matrix [matrix alphabet]
  (let [chars (take (count matrix) alphabet)]
    (println (str/join " " (repeat 1 "  ")) (str/join "  " chars))
    (doseq [i (range (count matrix))]
      (print (nth chars i) " ")
      (doseq [j (range (count (nth matrix i)))]
        (let [val (aget (nth matrix i) j)]
          (print val " ")))
      (println))))

(defn -main []
  (let [alphabet_power 4
        array (vector 9 1 6 7 3 4 5 10)
        sorted (sort array)
        map (divide-array sorted alphabet_power)
        chars (chars-array array map)
        matrix (generate-matrix chars)]
    (println "Початковий масив: " array )
    (println "Потужність алфавіту:" alphabet_power)
    (println "Відсортований масив:" sorted)
    (println "Результуючий лінгвістичний ряд:" chars)
    (println "Матриця передування:")
    (print-matrix matrix alphabet)
    ))

