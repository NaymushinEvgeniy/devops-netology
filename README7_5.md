# Домашнее задание к занятию "7.5. Основы golang"

1. Напишите программу для перевода метров в футы (1 фут = 0.3048 метр). Можно запросить исходные данные у пользователя, а можно статически задать в коде. Для взаимодействия с пользователем можно использовать функцию Scanf:


    package main
    import "fmt"
    
    func main() {
        // Example values
        var input float64 = 10
        // Foot / metre const
        const Kf = 0.3048
        // Calculation
        output := input * Kf
    
        fmt.Println(output)
    }
    
2. Напишите программу, которая найдет наименьший элемент в любом заданном списке, например:


    package main

    import "fmt"

    func MinValue(array []int) int {
        // Input slice of array in func
	    var min int = array[0]
        // Cycle of selection min value
	    for _, value := range array {
		    if min > value {
			    min = value
		    }
	    }
	    return min
    }
    
    func main() {
	    x := []int{48, 96, 86, 68, 57, 82, 63, 70, 37, 34, 83, 27, 19, 97, 9, 17}
	    fmt.Println(MinValue(x))
    }

3. Напишите программу, которая выводит числа от 1 до 100, которые делятся на 3. То есть (3, 6, 9, …).

    
    package main

    import "fmt"

    func main() {
	    for i := 1; i <= 100; i++ {
		    if i%3 == 0 {
			    fmt.Println(i)
			    continue
		    }
	    }
    }
