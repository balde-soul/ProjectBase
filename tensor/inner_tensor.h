/****************************************************************************
<one line to give the program's name and a brief idea of what it does.>
Copyright (C) <2020/5/23>  <JiHua Cao>
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.
This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.

*****************************************************************************/

#ifndef PROJECT_BASE_TENSOR_INNER_TENSOR_H
#define PROJECT_BASE_TENSOR_INNER_TENSOR_H
#include "ProjectBase/tensor/tensor.hpp"

namespace ProjectBase{
    namespace Tensor{
        class inner_tensor{
            public:
                friend ProjectBase::Tensor::Tensor;
            public:
                inner_tensor();
                inner_tensor(const ProjectBase::Tensor::inner_tensor& other);
                inner_tensor(ProjectBase::Tensor::inner_tensor&& ref);
            public:
        };
    }
}
#endif