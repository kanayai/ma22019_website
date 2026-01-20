
# Appendix {-}

## Background on PCA {-}

The following explanations motivate why we consider the eigenvalues and eigenvectors of the matrix $\Sigma$ to study the spatial struture in the data.

Let's return to the toy example in Figure \@ref(fig:ToyExample) and look at how we find the first direction mathematically. Suppose we have a data point $\mathbf{x}_t=(x_{1,t},x_{2,t})\in\mathbb{R}^2$ and a unit vector $\mathbf{u}\in\mathbb{R}^2$. Then using Year 1 Algebra, the projection of $\mathbf{x}_t$ onto the space spanned by $\mathbf{u}$ is 
\[
\mathbf{u}^{\mathrm{T}}\mathbf{x}_t\mathbf{u}. 
\]
Further, due to the linearity of the expectation, the mean of the projections is $\mathbf{u}^{\mathrm{T}}\bar{\mathbf{x}}\mathbf{u}$, where $\bar{x}$ is the vector of the mean values for $x_{1,1},\ldots,x_{1,T}$ and $x_{2,1},\ldots,x_{2,T}$ respectively. 

Principal component analysis then seeks the vector $\mathbf{u}$ which maximizes the variance in the projected values. Formally, the sample variance of the projection is
\[
\frac{1}{T}\sum_{t=1}^T\left[\mathbf{u}^{\mathrm{T}}\left(\mathbf{x}_t \bar{\mathbf{x}}\right)^2 \mathbf{u} \right] = 
\mathbf{u}^{\mathrm{T}}\left[\frac{1}{T}\sum_{t=1}^T\left(\mathbf{x}_t \bar{\mathbf{x}}\right)^2\right] \mathbf{u} = \mathbf{u}^{\mathrm{T}} \Sigma \mathbf{u}, 
\]
where $\Sigma$ is termed the **empirical covariance matrix**. 

To find $\mathbf{u}$, we now have to maximise $\mathbf{u}^{\mathrm{T}} \Sigma \mathbf{u}$ subject to $\mathbf{u}^{\mathrm{T}}\mathbf{u}=1$, since $\mathbf{u}$ is a unit vector. Solving this optimization problem gives us that the optimal $\mathbf{u}$ is the eigenvector of $\Sigma$ with the highest eigenvalue. Using an iterative procedure, we can also explain why the next direction to consider is the eigenvector with the second largest eigenvalue. This is the reason why we explore the eigenvectors in PCA.
