/****************************************************************************
<one line to give the program's name and a brief idea of what it does.>
Copyright (C) <2020/5/21>  <JiHua Cao>
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
#ifndef PROJECT_BASE_TENSOR_TENSOR_H
#define PROJECT_BASE_TENSOR_TENSOR_H
#include <boost/test/data/monomorphic/initializer_list.hpp>
//#include <unsupported/Eigen/CXX11/src/Tensor/Tensor.h>
#include <ProjectBase/tensor/Define.hpp>
#include <ProjectBase/tensor/tensor_shape.hpp>
#include <ProjectBase/tensor/tensor_type.hpp>
#include <boost/container/list.hpp>
#include <boost/container/vector.hpp>

namespace ProjectBase{
    namespace Tensor{
        class inner_tensor;
        /**
         * \brief brief
         * \note note
         * \author none
         * \since version
         * */
        class PROJECT_BASE_TENSOR_SYMBOL Tensor{
            public:
                /**
                 * \brief brief
                 * \note note
                 * */
                Tensor();
                /**
                 * \brief brief
                 * \note note
                 * \param[in] in
                 * \param[out] out
                 * */
                Tensor(const Tensor& other);
                /**
                 * \brief brief
                 * \note note
                 * \param[in] in
                 * \param[out] out
                 * */
                Tensor(Tensor&& ref);
                /**
                 * \brief brief
                 * \note note
                 * \author none
                 * \param[in] in
                 * \param[out] out
                 * \return return
                 * \retval retval
                 * \since version
                 * */
                Tensor(void* ptr);
                template<typename T> Tensor(const boost::container::vector<T>& vector){
                }
                template<typename T> Tensor(boost::container::vector<T>&& vector);
                ~Tensor();
            public:
                /**
                 * \brief brief
                 * \note note
                 * \author none
                 * \param[in] in
                 * \param[out] out
                 * \return return
                 * \retval retval
                 * \since version
                 * */
                const ProjectBase::Tensor::TensorShape& shape(int a) const;
                /**
                 * \brief brief
                 * \note note
                 * \author none
                 * \param[in] in
                 * \param[out] out
                 * \return return
                 * \retval retval
                 * \since version
                 * */
                const ProjectBase::Tensor::TensorType& type() const;
            public:
                const ProjectBase::Tensor::Tensor& slice() const;
                const ProjectBase::Tensor::Tensor& at(const unsigned long long& index, ...) const;
                const unsigned long long dim() const;
                const unsigned long long get_dim(const unsigned long long& dim) const;
            public:
                Tensor&& to_cuda(int cuda_id);
                Tensor&& to_cpu();
                void series(void** ptr, unsigned long long* size) const;
            public:
                //const ProjectBase::Tensor::Tensor& operator[]() const;
            private:
                ProjectBase::Tensor::inner_tensor* _impl;
        };
    }
}
#endif