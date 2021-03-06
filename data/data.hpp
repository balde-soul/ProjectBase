/****************************************************************************
<one line to give the program's name and a brief idea of what it does.>
Copyright (C) <2020>  <JiHua Cao>
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
#ifndef PROJECT_BASE_DATA_DATA_H
#define PROJECT_BASE_DATA_DATA_H
#include <ProjectBase/data/Define.hpp>

namespace ProjectBase{
    namespace Data{

        class PROJECT_BASE_DATA_SYMBOL Data{
            public:
                typedef const ProjectBase::Data::Data& (*_get_data_func)();
                typedef bool (*_set_data_func)(const ProjectBase::Data::Data& data);
            public:
                Data();
                Data(const Data& other);
                Data(Data&& ref);
        };
    }
}
#endif // ! PROJECT_BASE_FUNCTION_DATA_H