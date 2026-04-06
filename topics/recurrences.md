
## Root method


- We can solve "second-order" recurrence relations by finding roots of characteristic equation
- Method for generating solutions to recurrence relations of form $f_n + \alpha f_{n-1} + \beta f_{n-2} = 0$
- We guess that $f_n = r^n$, then factor and solve for $r$
- Example:

$$
\begin{align*}
& G_n = G_{n-1} + 6 G_{n-2} \\
\to & r^n - r^{n-1} - 6r^{n-2} = 0 \\
\to & r^{n-2} ( r^2 - r - 6 ) = r^{n-2} (r-3) (r+2)
\end{align*}
$$

Solutions $r=3$ and $r=-2$ are both valid, depending on initial conditions (check using original recurrence).

Solutions of $f_n + \alpha f_{n-1} + \beta f_{n-2} = 0$ can be found using roots
$r_1$, $r_2$ of the characteristic equation $x^2 + \alpha x + \beta = 0$, and in general solutions
take the form $f_n = a r_1^n + b r_2^n$.

Further reading [here](https://discrete.openmathbooks.org/dmoi2/sec_recurrence.html) and [here](https://math.stackexchange.com/a/167197).
